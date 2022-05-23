//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 23/05/2022.
//

import UIKit
import SwiftyJSON
class WeatherModel: NSObject , NSCoding{

    var current : WeatherCurrentModel!
    var daily : [WeatherDailyModel]!
    var lat : Float!
    var lon : Float!
    var minutely : [WeatherMinutelyModel]!
    var timezone : String!
    var timezoneOffset : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let currentJson = json["current"]
        if !currentJson.isEmpty{
            current = WeatherCurrentModel(fromJson: currentJson)
        }
        daily = [WeatherDailyModel]()
        let dailyArray = json["daily"].arrayValue
        for dailyJson in dailyArray{
            let value = WeatherDailyModel(fromJson: dailyJson)
            daily.append(value)
        }
        lat = json["lat"].floatValue
        lon = json["lon"].floatValue
        minutely = [WeatherMinutelyModel]()
        let minutelyArray = json["minutely"].arrayValue
        for minutelyJson in minutelyArray{
            let value = WeatherMinutelyModel(fromJson: minutelyJson)
            minutely.append(value)
        }
        timezone = json["timezone"].stringValue
        timezoneOffset = json["timezone_offset"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if current != nil{
            dictionary["current"] = current.toDictionary()
        }
        if daily != nil{
            var dictionaryElements = [[String:Any]]()
            for dailyElement in daily {
                dictionaryElements.append(dailyElement.toDictionary())
            }
            dictionary["daily"] = dictionaryElements
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if lon != nil{
            dictionary["lon"] = lon
        }
        if minutely != nil{
            var dictionaryElements = [[String:Any]]()
            for minutelyElement in minutely {
                dictionaryElements.append(minutelyElement.toDictionary())
            }
            dictionary["minutely"] = dictionaryElements
        }
        if timezone != nil{
            dictionary["timezone"] = timezone
        }
        if timezoneOffset != nil{
            dictionary["timezone_offset"] = timezoneOffset
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         current = aDecoder.decodeObject(forKey: "current") as? WeatherCurrentModel
         daily = aDecoder.decodeObject(forKey: "daily") as? [WeatherDailyModel]
         lat = aDecoder.decodeObject(forKey: "lat") as? Float
         lon = aDecoder.decodeObject(forKey: "lon") as? Float
         minutely = aDecoder.decodeObject(forKey: "minutely") as? [WeatherMinutelyModel]
         timezone = aDecoder.decodeObject(forKey: "timezone") as? String
         timezoneOffset = aDecoder.decodeObject(forKey: "timezone_offset") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if current != nil{
            aCoder.encode(current, forKey: "current")
        }
        if daily != nil{
            aCoder.encode(daily, forKey: "daily")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lon != nil{
            aCoder.encode(lon, forKey: "lon")
        }
        if minutely != nil{
            aCoder.encode(minutely, forKey: "minutely")
        }
        if timezone != nil{
            aCoder.encode(timezone, forKey: "timezone")
        }
        if timezoneOffset != nil{
            aCoder.encode(timezoneOffset, forKey: "timezone_offset")
        }

    }

}
