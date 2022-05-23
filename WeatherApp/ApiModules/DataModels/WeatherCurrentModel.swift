//
//  WeatherCurrentModel.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit
import SwiftyJSON
class WeatherCurrentModel: NSObject , NSCoding{

    var clouds : Int!
    var dewPoint : Float!
    var dt : Int!
    var feelsLike : Float!
    var humidity : Int!
    var pressure : Int!
    var sunrise : Int!
    var sunset : Int!
    var temp : Float!
    var uvi : Float!
    var visibility : Int!
    var weather : [WeatherDetailModel]!
    var windDeg : Int!
    var windSpeed : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        clouds = json["clouds"].intValue
        dewPoint = json["dew_point"].floatValue
        dt = json["dt"].intValue
        feelsLike = json["feels_like"].floatValue
        humidity = json["humidity"].intValue
        pressure = json["pressure"].intValue
        sunrise = json["sunrise"].intValue
        sunset = json["sunset"].intValue
        temp = json["temp"].floatValue
        uvi = json["uvi"].floatValue
        visibility = json["visibility"].intValue
        weather = [WeatherDetailModel]()
        let weatherArray = json["weather"].arrayValue
        for weatherJson in weatherArray{
            let value = WeatherDetailModel(fromJson: weatherJson)
            weather.append(value)
        }
        windDeg = json["wind_deg"].intValue
        windSpeed = json["wind_speed"].floatValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if clouds != nil{
            dictionary["clouds"] = clouds
        }
        if dewPoint != nil{
            dictionary["dew_point"] = dewPoint
        }
        if dt != nil{
            dictionary["dt"] = dt
        }
        if feelsLike != nil{
            dictionary["feels_like"] = feelsLike
        }
        if humidity != nil{
            dictionary["humidity"] = humidity
        }
        if pressure != nil{
            dictionary["pressure"] = pressure
        }
        if sunrise != nil{
            dictionary["sunrise"] = sunrise
        }
        if sunset != nil{
            dictionary["sunset"] = sunset
        }
        if temp != nil{
            dictionary["temp"] = temp
        }
        if uvi != nil{
            dictionary["uvi"] = uvi
        }
        if visibility != nil{
            dictionary["visibility"] = visibility
        }
        if weather != nil{
            var dictionaryElements = [[String:Any]]()
            for weatherElement in weather {
                dictionaryElements.append(weatherElement.toDictionary())
            }
            dictionary["weather"] = dictionaryElements
        }
        if windDeg != nil{
            dictionary["wind_deg"] = windDeg
        }
        if windSpeed != nil{
            dictionary["wind_speed"] = windSpeed
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         clouds = aDecoder.decodeObject(forKey: "clouds") as? Int
         dewPoint = aDecoder.decodeObject(forKey: "dew_point") as? Float
         dt = aDecoder.decodeObject(forKey: "dt") as? Int
         feelsLike = aDecoder.decodeObject(forKey: "feels_like") as? Float
         humidity = aDecoder.decodeObject(forKey: "humidity") as? Int
         pressure = aDecoder.decodeObject(forKey: "pressure") as? Int
         sunrise = aDecoder.decodeObject(forKey: "sunrise") as? Int
         sunset = aDecoder.decodeObject(forKey: "sunset") as? Int
         temp = aDecoder.decodeObject(forKey: "temp") as? Float
         uvi = aDecoder.decodeObject(forKey: "uvi") as? Float
         visibility = aDecoder.decodeObject(forKey: "visibility") as? Int
         weather = aDecoder.decodeObject(forKey: "weather") as? [WeatherDetailModel]
         windDeg = aDecoder.decodeObject(forKey: "wind_deg") as? Int
         windSpeed = aDecoder.decodeObject(forKey: "wind_speed") as? Float

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if clouds != nil{
            aCoder.encode(clouds, forKey: "clouds")
        }
        if dewPoint != nil{
            aCoder.encode(dewPoint, forKey: "dew_point")
        }
        if dt != nil{
            aCoder.encode(dt, forKey: "dt")
        }
        if feelsLike != nil{
            aCoder.encode(feelsLike, forKey: "feels_like")
        }
        if humidity != nil{
            aCoder.encode(humidity, forKey: "humidity")
        }
        if pressure != nil{
            aCoder.encode(pressure, forKey: "pressure")
        }
        if sunrise != nil{
            aCoder.encode(sunrise, forKey: "sunrise")
        }
        if sunset != nil{
            aCoder.encode(sunset, forKey: "sunset")
        }
        if temp != nil{
            aCoder.encode(temp, forKey: "temp")
        }
        if uvi != nil{
            aCoder.encode(uvi, forKey: "uvi")
        }
        if visibility != nil{
            aCoder.encode(visibility, forKey: "visibility")
        }
        if weather != nil{
            aCoder.encode(weather, forKey: "weather")
        }
        if windDeg != nil{
            aCoder.encode(windDeg, forKey: "wind_deg")
        }
        if windSpeed != nil{
            aCoder.encode(windSpeed, forKey: "wind_speed")
        }

    }

}
