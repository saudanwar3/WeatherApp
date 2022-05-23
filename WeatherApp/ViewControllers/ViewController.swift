//
//  ViewController.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 22/05/2022.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlet
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
