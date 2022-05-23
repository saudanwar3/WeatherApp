//
//  WeatherTempModel.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit
import SwiftyJSON
class WeatherTempModel: NSObject , NSCoding{

    var day : Float!
    var eve : Float!
    var max : Float!
    var min : Float!
    var morn : Float!
    var night : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        day = json["day"].floatValue
        eve = json["eve"].floatValue
        max = json["max"].floatValue
        min = json["min"].floatValue
        morn = json["morn"].floatValue
        night = json["night"].floatValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if day != nil{
            dictionary["day"] = day
        }
        if eve != nil{
            dictionary["eve"] = eve
        }
        if max != nil{
            dictionary["max"] = max
        }
        if min != nil{
            dictionary["min"] = min
        }
        if morn != nil{
            dictionary["morn"] = morn
        }
        if night != nil{
            dictionary["night"] = night
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         day = aDecoder.decodeObject(forKey: "day") as? Float
         eve = aDecoder.decodeObject(forKey: "eve") as? Float
         max = aDecoder.decodeObject(forKey: "max") as? Float
         min = aDecoder.decodeObject(forKey: "min") as? Float
         morn = aDecoder.decodeObject(forKey: "morn") as? Float
         night = aDecoder.decodeObject(forKey: "night") as? Float

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if day != nil{
            aCoder.encode(day, forKey: "day")
        }
        if eve != nil{
            aCoder.encode(eve, forKey: "eve")
        }
        if max != nil{
            aCoder.encode(max, forKey: "max")
        }
        if min != nil{
            aCoder.encode(min, forKey: "min")
        }
        if morn != nil{
            aCoder.encode(morn, forKey: "morn")
        }
        if night != nil{
            aCoder.encode(night, forKey: "night")
        }

    }

}
