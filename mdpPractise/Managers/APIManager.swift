
//  APIManager.swift
//  Sqrrl
//
//  Created by Anil Sharma on 25/10/16.
//  Copyright © 2016 Sqrrl Fintech Pvt. Ltd. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Sugar

let BaseURL = "http://13.71.115.17/my_pms2/mdpapi/"
//const val PREF_base_url = "https://www.mydentalpractice.in/my_pms2/mdpapi/"

enum APIEndPoint: String {
    case UserLogin              = "userAPI/otp_login"
}

func apiURL(_ endPoint: APIEndPoint) -> String {
    return BaseURL + endPoint.rawValue
}

let apiManager = APIManager.sharedInstance

//Headers
let AuthTokenHeaderKey  = "Authorization"
let APIKeyHeaderKey     = "API-key"
let DeviceUuidKey       = "DeviceID"
let appVersionKey       = "app-version"
let HeaderContentType   = "Content-Type"

class APIManager {
    
    
    class var sharedInstance: APIManager {
        struct Static {
            static let instance: APIManager = APIManager()
        }
        return Static.instance
    }
    
    //MARK: - Requests
    
    
    func  alamofireTimeoutInterval() {
        let manager = AF
        manager.session.configuration.timeoutIntervalForRequest = 120
    }
    
    func makeRequest(_ path: String, action: Alamofire.HTTPMethod = .get, params: [String: Any]? = nil, completionHandler:@escaping (_ successful: Bool, _ response: JSON, _ error: NSError?)->()) -> Request {
        
        var headers: HTTPHeaders = [:]
//        if let token = UserDefaultManager.sharedInstance.token() {
//        headers[AuthTokenHeaderKey] = "Bearer \(token)"
////        headers["x-debug-id"] = "278189"
//        }else if let deviceID = kDeviceUuid {
//            headers[DeviceUuidKey] = "\(deviceID)"
//        }
        
        headers[HeaderContentType] = "application/json"
        //headers[appVersionKey] = appVersion
        
//        if path.hasPrefix("http://itunes.apple.com") || path.hasPrefix("https://itunes.apple.com"){
//            headers = [:]
//        }

         print(headers)
        let request = AF.request(path, method: action, parameters: params,encoding: Alamofire.JSONEncoding.default, headers: headers).responseData { description in print(description) }.validate().responseJSON { response in
            
            var responseStr = ""
            if let _  = response.data {
                responseStr = String.init(data: response.data!, encoding: String.Encoding.utf8)!
                debugPrint(String.init(data: response.data!, encoding: String.Encoding.utf8)!)
            }
            
            DispatchQueue.main.async {
                if Platform.isSimulator {
                    if let data = response.data {
                        if let utf8Text = try? JSONSerialization.jsonObject(with: data, options: []) {
                            debugPrint(utf8Text)
                        }
                    }
                }
                switch response.result {
                case .success(let json):
                    let parsedJSON = JSON(json)
                    //debugPrint("response : \(parsedJSON)")
                    //print("response : \(parsedJSON)")
                    completionHandler(true, parsedJSON, nil)
                case .failure(let error):
                    debugPrint("Error calling service: \(error)\n")
                    
                    if (response.response?.statusCode ?? 0 == 200) || (response.response?.statusCode ?? 0 == 201) {
                        completionHandler(true, JSON(["":""]), nil)
                        return;
                    }else if (response.response?.statusCode ?? 0 == 401) {
                        if let dashboardVc = (kAppDelegate.window?.rootViewController as? UINavigationController)?.viewControllers[0] as? TabbarControllerVC {
                            let topVC = (kAppDelegate.window?.rootViewController as? UINavigationController)?.visibleViewController
                           // dashboardVc.showLogoutView(topVC)
                            return;
                        }
                    }else if (response.response?.statusCode ?? 0 == 400) {
                        var parms : [String : Any] = [:]
                        
                        if let data = response.data {
                            if let utf8Text = try? JSONSerialization.jsonObject(with: data, options: []) , utf8Text is [String : Any]  {
                                for (key, value) in utf8Text as! [String : Any]{// For error parms
                                    parms[key] = value
                                }
                            }
                        }
                        
                        if let errorTitle = parms["title"] as? String, errorTitle == "Missing header value" {
                            if let dashboardVc = (kAppDelegate.window?.rootViewController as? UINavigationController)?.viewControllers[0] as? TabbarControllerVC {
                                let topVC = (kAppDelegate.window?.rootViewController as? UINavigationController)?.visibleViewController
                                //dashboardVc.showLogoutView(topVC)
                                return;
                            }
                        }
                    }
                    
                    let httpStatus = (response.response != nil) ? response.response!.statusCode : ((error as NSError?)?.code ?? 0)
                    let parameters = (params != nil) ? params! : [:]
                    let urlString = path.split("?")[0]
//                    let errorStr = response.result.error.debugDescription.trimAlamofireString()
                    let errorStr =  (response.response != nil) ? response.response!.description : ((error as NSError?)?.localizedDescription ?? error.errorDescription ?? "")
                    var isTokenPass = false
                    if let _ = UserDefaultManager.sharedInstance.token() { isTokenPass = true }

                    //Capture Sentry Event
                    let extra =  [
                        "URL": urlString,
                        "Error Description": error.localizedDescription,
                        "HTTP Status": httpStatus,
                        "Params": parameters,
                        "response": responseStr,
                        "isTokenPass":isTokenPass
                    ] as [String : Any]
                    
                    var parms : [String : Any] = ["StatusCode" : httpStatus]
                    if let data = response.data {
                        if let utf8Text = try? JSONSerialization.jsonObject(with: data, options: []) , utf8Text is [String : Any]  {
                            for (key, value) in utf8Text as! [String : Any]{// For error parms
                                parms[key] = value
                            }
                        }
                    }
                    
                    var apiError : NSError?
                    if  let _ = error as NSError? {
                        apiError = NSError(domain: error.errorDescription ?? "", code: httpStatus, userInfo: parms)
                    }
                    completionHandler(false, JSON(["":""]), apiError)
                }
            }
        }
        
        if Platform.isSimulator {
            debugPrint("Debug Print (request.description): \(request.description)")
            debugPrint(request)
        }
        return request
    }
}
