//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 23/05/2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var WeatherLbl: UILabel!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var moonriseLbl: UILabel!
    @IBOutlet weak var moonsetLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var morningLbl: UILabel!
    @IBOutlet weak var eveningLbl: UILabel!
    @IBOutlet weak var nightLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var windspeedLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var weatherDescLbl: UILabel!
    var cityStr:String = ""
    var tempStr:String = ""
    var weatherStr:String = ""
    var imgCode:String = ""
    var model:WeatherDailyModel?
    class func instantiateFromStoryboard() -> WeatherDetailViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! WeatherDetailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityLbl.text = cityStr
        self.tempLbl.text = tempStr
        self.WeatherLbl.text = weatherStr
        self.sunriseLbl.text = "Sunrise: " + (Double((self.model?.sunrise)!)).getDateStringFromUTC()
        self.sunsetLbl.text = "Sunset: " + (Double((self.model?.sunset)!)).getDateStringFromUTC()
        self.moonriseLbl.text = "Moonrise: " + (Double((self.model?.moonrise)!)).getDateStringFromUTC()
        self.moonsetLbl.text = "Moonset: " + (Double((self.model?.moonset)!)).getDateStringFromUTC()
        self.dayLbl.text = "Day: \(self.model?.temp.day ?? 00) °F"
        self.minLbl.text = "Minimum: \(self.model?.temp.min ?? 00) °F"
        self.maxLbl.text = "Maximum: \(self.model?.temp.max ?? 00) °F"
        self.morningLbl.text = "Morning: \(self.model?.temp.morn ?? 00) °F"
        self.eveningLbl.text = "Evening: \(self.model?.temp.eve ?? 00) °F"
        self.nightLbl.text = "Night: \(self.model?.temp.night ?? 00) °F"
        self.pressureLbl.text = "Pressure: \(self.model?.pressure ?? 00)"
        self.windspeedLbl.text = "Windspeed: \(self.model?.windSpeed ?? 00)"
        self.weatherTypeLbl.text = "Weather Type: \(self.model?.weather.first?.main ?? "")"
        self.weatherDescLbl.text = "Weather Type: \(self.model?.weather.first?.descriptionField ?? "")"
        self.iconImgView.image = UIImage(systemName:self.imgCode)

    }

}
