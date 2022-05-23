//
//  WeatherDailyModel.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit
import SwiftyJSON

class WeatherDailyModel: NSObject , NSCoding{

    var clouds : Int!
    var dewPoint : Float!
    var dt : Int!
    var feelsLike : WeatherFeelsLikeModel!
    var humidity : Int!
    var moonPhase : Int!
    var moonrise : Int!
    var moonset : Int!
    var pop : Int!
    var pressure : Int!
    var rain : Float!
    var sunrise : Int!
    var sunset : Int!
    var temp : WeatherTempModel!
    var uvi : Int!
    var weather : [WeatherDetailModel]!
    var windDeg : Int!
    var windGust : Int!
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
        let feelsLikeJson = json["feels_like"]
        if !feelsLikeJson.isEmpty{
            feelsLike = WeatherFeelsLikeModel(fromJson: feelsLikeJson)
        }
        humidity = json["humidity"].intValue
        moonPhase = json["moon_phase"].intValue
        moonrise = json["moonrise"].intValue
        moonset = json["moonset"].intValue
        pop = json["pop"].intValue
        pressure = json["pressure"].intValue
        rain = json["rain"].floatValue
        sunrise = json["sunrise"].intValue
        sunset = json["sunset"].intValue
        let tempJson = json["temp"]
        if !tempJson.isEmpty{
            temp = WeatherTempModel(fromJson: tempJson)
        }
        uvi = json["uvi"].intValue
        weather = [WeatherDetailModel]()
        let weatherArray = json["weather"].arrayValue
        for weatherJson in weatherArray{
            let value = WeatherDetailModel(fromJson: weatherJson)
            weather.append(value)
        }
        windDeg = json["wind_deg"].intValue
        windGust = json["wind_gust"].intValue
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
            dictionary["feels_like"] = feelsLike.toDictionary()
        }
        if humidity != nil{
            dictionary["humidity"] = humidity
        }
        if moonPhase != nil{
            dictionary["moon_phase"] = moonPhase
        }
        if moonrise != nil{
            dictionary["moonrise"] = moonrise
        }
        if moonset != nil{
            dictionary["moonset"] = moonset
        }
        if pop != nil{
            dictionary["pop"] = pop
        }
        if pressure != nil{
            dictionary["pressure"] = pressure
        }
        if rain != nil{
            dictionary["rain"] = rain
        }
        if sunrise != nil{
            dictionary["sunrise"] = sunrise
        }
        if sunset != nil{
            dictionary["sunset"] = sunset
        }
        if temp != nil{
            dictionary["temp"] = temp.toDictionary()
        }
        if uvi != nil{
            dictionary["uvi"] = uvi
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
        if windGust != nil{
            dictionary["wind_gust"] = windGust
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
         feelsLike = aDecoder.decodeObject(forKey: "feels_like") as? WeatherFeelsLikeModel
         humidity = aDecoder.decodeObject(forKey: "humidity") as? Int
         moonPhase = aDecoder.decodeObject(forKey: "moon_phase") as? Int
         moonrise = aDecoder.decodeObject(forKey: "moonrise") as? Int
         moonset = aDecoder.decodeObject(forKey: "moonset") as? Int
         pop = aDecoder.decodeObject(forKey: "pop") as? Int
         pressure = aDecoder.decodeObject(forKey: "pressure") as? Int
         rain = aDecoder.decodeObject(forKey: "rain") as? Float
         sunrise = aDecoder.decodeObject(forKey: "sunrise") as? Int
         sunset = aDecoder.decodeObject(forKey: "sunset") as? Int
         temp = aDecoder.decodeObject(forKey: "temp") as? WeatherTempModel
         uvi = aDecoder.decodeObject(forKey: "uvi") as? Int
         weather = aDecoder.decodeObject(forKey: "weather") as? [WeatherDetailModel]
         windDeg = aDecoder.decodeObject(forKey: "wind_deg") as? Int
         windGust = aDecoder.decodeObject(forKey: "wind_gust") as? Int
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
        if moonPhase != nil{
            aCoder.encode(moonPhase, forKey: "moon_phase")
        }
        if moonrise != nil{
            aCoder.encode(moonrise, forKey: "moonrise")
        }
        if moonset != nil{
            aCoder.encode(moonset, forKey: "moonset")
        }
        if pop != nil{
            aCoder.encode(pop, forKey: "pop")
        }
        if pressure != nil{
            aCoder.encode(pressure, forKey: "pressure")
        }
        if rain != nil{
            aCoder.encode(rain, forKey: "rain")
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
        if weather != nil{
            aCoder.encode(weather, forKey: "weather")
        }
        if windDeg != nil{
            aCoder.encode(windDeg, forKey: "wind_deg")
        }
        if windGust != nil{
            aCoder.encode(windGust, forKey: "wind_gust")
        }
        if windSpeed != nil{
            aCoder.encode(windSpeed, forKey: "wind_speed")
        }

    }

}
