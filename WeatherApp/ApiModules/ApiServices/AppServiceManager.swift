//
//  AppServiceManager.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit
import SwiftyJSON
import Alamofire

class AppServiceManager {

    static func getWeatherService(param:[String:String],apiName:String,
                          completionHandler:@escaping (_ success:Bool,_ response:WeatherModel,_ error:Any?)->Void){
        ServiceLayer.sendRequestWithGETWithDynamicEncodingWithHeaders(parameters: param, apiName: apiName, encoding: URLEncoding.default , headers: ApiManager.headers() ) { (status:Bool, response:JSON, error:AnyObject?) in
            let model = WeatherModel(fromJson: response)
            completionHandler(true, model, response[APIConstants.SERVICESTATE])
        }
    }
}
    
