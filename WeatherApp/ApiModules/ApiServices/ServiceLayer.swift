//
//  ServiceLayer.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServiceLayer: NSObject {
    
    struct STATUS_CODE  {
        static let UNAUTHENTICATED = 401
        static let FORBIDDEN = 403
        static let VALIDATION_ERROR = 404
        static let NOT_FOUND = 402
        static let UNIDENTIFIED = 500
        static let SUCCESS = 200
    }
    
    static let isShowError = false
    
    /**
     ** POST Method for calling API
     *  Services gateway
     *  Method  get response from server
     *  @parameter              -> requestObject: request josn object ,apiName: api endpoint
     *  @returm                 -> void
     *  @compilationHandler     -> success: status of api, response: respose from server, error: error handling
     **/
    
    static func sendRequestWithPOSTWithDynamicEncodingWithHeaders(parameters:[String:String], apiName : String, encoding: ParameterEncoding, headers: HTTPHeaders,
                                                                  completionHandler:
                                                                  @escaping (_ success : Bool, _ response : JSON, _ error : AnyObject?) -> Void) {
        
        print("\(APIConstants.SERVICEURL) \(apiName)")
        
        if let paramPrettyJson = parameters.prettyPrintedJSON {
            print("\(APIConstants.SERVICEPARAMETERS) \(paramPrettyJson)")
        }
        
        //Mark check internet Connectivity
        if !ConnectionHelper.sharedInstance.isConnectedToNetwork(){
            Alert.showAlert(title: "No Internet Connection", message: "Make sure your device is connected to internet");
            let json: JSON =  ["message": "No Internet Connection" , "error": "No Internet Connection"]
            
            completionHandler(false,json,nil)
            return;
        }
        
        AF.request(apiName, method:HTTPMethod.post, parameters: parameters , encoding:  encoding, headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                
                print("--------Response In JSON Format-----")
                print(response)
                
                if let value: Any = response.value as AnyObject? {
                    let response = JSON(value)
                    completionHandler(true, response   ,nil)
                    // let response = JSON(value)
                }
            case .failure(_):
                print("Request failed with error: \(response.error!)")
                //403,200
                let json: JSON =  ["message": "Something went wrong!" , "error": "Something went wrong!"]
                completionHandler(false,json,nil)
                
                
                if response.response?.statusCode == STATUS_CODE.VALIDATION_ERROR{
                    let response_json = JSON(response.data!)
                    print(response_json)
                    if isShowError {
                        Alert.showAlert(title: "ALERT", message: response_json["message"].string ?? "no error in message")
                    }
                }
                if response.response?.statusCode == STATUS_CODE.FORBIDDEN{
                    let response_json = JSON(response.data!)
                    print(response_json)
                    if isShowError {
                        Alert.showAlert(title: "ALERT", message: response_json["message"].string ?? "no error in message")
                    }
                }
                if response.response?.statusCode == STATUS_CODE.NOT_FOUND{
                    let response_json = JSON(response.data!)
                    
                    print(response_json)
                    Alert.showAlert(title: "Error", message: response.error!.localizedDescription)
                    
                    return
                }
            }
            if response.response?.statusCode == STATUS_CODE.UNAUTHENTICATED{
                return
                
            }
            if response.response?.statusCode == STATUS_CODE.UNIDENTIFIED{
                Alert.hideLoader()
                return
            }
            if isShowError {
                print((response.error!).localizedDescription)
                return
                
            }
        }
    }
    
    static func sendRequestWithGETWithDynamicEncodingWithHeaders(parameters:[String:String], apiName : String, encoding: ParameterEncoding, headers: HTTPHeaders,
                                                                 completionHandler:
                                                                 @escaping (_ success : Bool, _ response : JSON, _ error : AnyObject?) -> Void) {
        
        print("\(APIConstants.SERVICEURL) \(apiName)")
        
        if let paramPrettyJson = parameters.prettyPrintedJSON {
            print("\(APIConstants.SERVICEPARAMETERS) \(paramPrettyJson)")
        }
        
        //Mark check internet Connectivity
        if !ConnectionHelper.sharedInstance.isConnectedToNetwork(){
            Alert.showAlert(title: "No Internet Connection", message: "Make sure your device is connected to internet");
            let json: JSON =  ["message": "No Internet Connection" , "error": "No Internet Connection"]
            
            completionHandler(false,json,nil)
            return;
        }
        
        AF.request(apiName, method:HTTPMethod.get, parameters: parameters , encoding:  encoding, headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                
                print("--------Response In JSON Format-----")
                print(response)
                
                if let value: Any = response.value as AnyObject? {
                    let response = JSON(value)
                    completionHandler(true, response   ,nil)
                    // let response = JSON(value)
                }
            case .failure(_):
                print("Request failed with error: \(response.error!)")
                //403,200
                let json: JSON =  ["message": "Something went wrong!" , "error": "Something went wrong!"]
                completionHandler(false,json,nil)
                
                
                if response.response?.statusCode == STATUS_CODE.VALIDATION_ERROR{
                    let response_json = JSON(response.data!)
                    print(response_json)
                    if isShowError {
                        Alert.showAlert(title: "ALERT", message: response_json["message"].string ?? "no error in message")
                    }
                }
                if response.response?.statusCode == STATUS_CODE.FORBIDDEN{
                    let response_json = JSON(response.data!)
                    print(response_json)
                    if isShowError {
                        Alert.showAlert(title: "ALERT", message: response_json["message"].string ?? "no error in message")
                    }
                }
                if response.response?.statusCode == STATUS_CODE.NOT_FOUND{
                    let response_json = JSON(response.data!)
                    
                    print(response_json)
                    Alert.showAlert(title: "Error", message: response.error!.localizedDescription)
                    
                    return
                }
            }
            if response.response?.statusCode == STATUS_CODE.UNAUTHENTICATED{
                return
                
            }
            if response.response?.statusCode == STATUS_CODE.UNIDENTIFIED{
                Alert.hideLoader()
                return
            }
            if isShowError {
                print((response.error!).localizedDescription)
                return
                
            }
        }
    }
    
    static func sendRequestWithPutWithDynamicEncodingWithHeaders(parameters:[String:String], apiName : String, encoding: ParameterEncoding, headers: HTTPHeaders,
                                                                 completionHandler:
                                                                 @escaping (_ success : Bool, _ response : JSON, _ error : AnyObject?) -> Void) {
        
        print("\(APIConstants.SERVICEURL) \(apiName)")
        
        if let paramPrettyJson = parameters.prettyPrintedJSON {
            print("\(APIConstants.SERVICEPARAMETERS) \(paramPrettyJson)")
        }
        
        //Mark check internet Connectivity
        if !ConnectionHelper.sharedInstance.isConnectedToNetwork(){
            Alert.showAlert(title: "No Internet Connection", message: "Make sure your device is connected to internet");
            let json: JSON =  ["message": "No Internet Connection" , "error": "No Internet Connection"]
            
            completionHandler(false,json,nil)
            return;
        }
        
        AF.request(apiName, method:HTTPMethod.put, parameters: parameters , encoding:  encoding, headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                
                print("--------Response In JSON Format-----")
                print(response)
                
                if let value: Any = response.value as AnyObject? {
                    let response = JSON(value)
                    completionHandler(true, response   ,nil)
                    // let response = JSON(value)
                }
            case .failure(_):
                print("Request failed with error: \(response.error!)")
                //403,200
                let json: JSON =  ["message": "Something went wrong!" , "error": "Something went wrong!"]
                completionHandler(false,json,nil)
                
                
                if response.response?.statusCode == STATUS_CODE.VALIDATION_ERROR{
                    let response_json = JSON(response.data!)
                    print(response_json)
                    if isShowError {
                        Alert.showAlert(title: "ALERT", message: response_json["message"].string ?? "no error in message")
                    }
                }
                if response.response?.statusCode == STATUS_CODE.FORBIDDEN{
                    let response_json = JSON(response.data!)
                    print(response_json)
                    if isShowError {
                        Alert.showAlert(title: "ALERT", message: response_json["message"].string ?? "no error in message")
                    }
                }
                if response.response?.statusCode == STATUS_CODE.NOT_FOUND{
                    let response_json = JSON(response.data!)
                    
                    print(response_json)
                    Alert.showAlert(title: "Error", message: response.error!.localizedDescription)
                    
                    return
                }
            }
            if response.response?.statusCode == STATUS_CODE.UNAUTHENTICATED{
                return
                
            }
            if response.response?.statusCode == STATUS_CODE.UNIDENTIFIED{
                Alert.hideLoader()
                return
            }
            if isShowError {
                print((response.error!).localizedDescription)
                return
                
            }
        }
    }

}

extension Dictionary {
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
}
