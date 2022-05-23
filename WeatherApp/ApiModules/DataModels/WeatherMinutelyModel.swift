//
//  WeatherMinutelyModel.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 23/05/2022.
//

import UIKit
import SwiftyJSON
class WeatherMinutelyModel: NSObject , NSCoding{

    var dt : Int!
    var precipitation : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        dt = json["dt"].intValue
        precipitation = json["precipitation"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dt != nil{
            dictionary["dt"] = dt
        }
        if precipitation != nil{
            dictionary["precipitation"] = precipitation
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         dt = aDecoder.decodeObject(forKey: "dt") as? Int
         precipitation = aDecoder.decodeObject(forKey: "precipitation") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if dt != nil{
            aCoder.encode(dt, forKey: "dt")
        }
        if precipitation != nil{
            aCoder.encode(precipitation, forKey: "precipitation")
        }

    }

}
