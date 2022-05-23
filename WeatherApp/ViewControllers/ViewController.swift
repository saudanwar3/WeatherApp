//
//  ViewController.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 22/05/2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    var weatherArray: [WeatherDailyModel] = [WeatherDailyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherTableView.delegate = self
        self.weatherTableView.dataSource = self
        let nib = UINib.init(nibName: String(describing: WeatherTableViewCell.self), bundle: nil)
        self.weatherTableView.register(nib, forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
        self.weatherTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 94, right: 0);
        self.getWeatherData()
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }

                    // Schedule Local Notification
                })
            case .authorized:
                print("Application Authorized to Display Notifications")
            case .denied:
                print("Application Not Allowed to Display Notifications")
            case .provisional:
                print("Application Provisional Allowed to Display Notifications")
            case .ephemeral:
                print("Application Ephemeral Allowed to Display Notifications")

            @unknown default:
                print("Application Default Allowed to Display Notifications")

            }
        }
        
        UNUserNotificationCenter.current().delegate = self

    }
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }

            completionHandler(success)
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: WeatherTableViewCell.self)) as! WeatherTableViewCell
        cell.dateLbl.text = "Date: " + (Double(self.weatherArray[indexPath.row].dt)).getDateStringFromUTC()
        cell.tempLbl.text = "Temp: " + String(self.weatherArray[indexPath.row].temp.day) + " °F"
        cell.feelsLikeLbl.text = "Temp: " + String(self.weatherArray[indexPath.row].feelsLike.day) + " °F"
        if let weatherType = self.weatherArray[indexPath.row].weather.first?.main {
            cell.weatherTypeLbl.text = "Weather Type: " + weatherType
        }
        if let weatherCode = self.weatherArray[indexPath.row].weather.first?.id {
            cell.iconImgView.image = UIImage(systemName:self.getSystemIcon(conditionCode: weatherCode))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = WeatherDetailViewController.instantiateFromStoryboard()
        vc.cityStr = self.cityLbl.text!
        vc.tempStr = self.tempLbl.text!
        vc.weatherStr = self.weatherLbl.text!
        if let weatherCode = self.weatherArray[indexPath.row].weather.first?.id {
            vc.imgCode = self.getSystemIcon(conditionCode: weatherCode)
        }
        vc.model = self.weatherArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController
{
    func getWeatherData() -> Void {
        
        Alert.showLoader(message: "")
        let param:[String:String] = [String:String]()
        let api = "\(Constants.BaseURL)lat=25.276987&lon=55.296249&units=imperial&appid=\(Constants.WeatherKey)"
        AppServiceManager.getWeatherService(param: param, apiName: api) { (success, response, message) in
            if success == true{
                print(response)
                print(message!)
                print(success)
                self.cityLbl.text = "Dubai"
                self.tempLbl.text = String(response.current.temp) + " °F"
                self.weatherLbl.text = response.current.weather.first?.main

                for obj in response.daily
                {
                    self.weatherArray.append(obj)
                }
                self.weatherTableView.reloadData()
                
                let notificationContent = UNMutableNotificationContent()

                // Configure Notification Content
                notificationContent.title = "Weather"
                notificationContent.subtitle = "Today Temp is " + String(response.current.temp) + " °F"
                notificationContent.body = "Today Weather is " + (response.current.weather.first?.main)!

                // Add Trigger
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)

                // Create Notification Request
                let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)

                // Add Request to User Notification Center
                UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                    if let error = error {
                        print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                    }
                }

            }
            else
            {
                Alert.showAlert(title: "Error", message: "Something went wrong! Please try later")
                Alert.hideLoader()
            }
        }
    }
    
    func getSystemIcon(conditionCode:Int)-> String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
extension ViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.badge,.sound])
    }

}
