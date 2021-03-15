
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
    case NewClinic              = "clinicAPI/new_clinic"
    case SignUp                 = "prospectAPI/new_prospect"
    case City                   = "mdpapi/?action=cities"
    case State                  = "mdpapi/?action=states"
    case NewAppointment         = "appointmentAPI/new_appointmen"
    case ClinicList             = "clinicAPI/list_clinic"
    case AppointmentList        = "appointmentAPI/list_appointment"
    case CancelAppointment      = "appointmentAPI/cancel_appointment"
    case AcceptAppointment      = "appointmentAPI/confirm_appointment"
    case doctorList             = "clinicAPI/list_doc_clinic"
    case ClinicDetail           = "clinicAPI/get_clinic"
    case DeleteClinic           = "clinicAPI/delete_clinic"
    case UpdateClinic           = "clinicAPI/update_clinic"
    case AppointmentByMonth     = "appointmentAPI/list_appointment_count_bymonth"
    case AppointmentByDay       = "appointmentAPI/list_appointments_byday"
    case TreatmentList          = "mdpapi/gettreatments"
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
        
        var apiError : NSError?
        var headers: HTTPHeaders = [:]
        
        headers[HeaderContentType] = "application/json"
        print(path)
        print(headers)
        print(params)
        let request = AF.request(path, method: action, parameters: params,encoding: Alamofire.JSONEncoding.default, headers: headers).responseData { description in print(description) }.validate().responseJSON { response in
                        
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
                    debugPrint("Error calling service: \(String(describing: error.errorDescription))\n")
                    
                    if (response.response?.statusCode ?? 0 == 200) || (response.response?.statusCode ?? 0 == 201) {
                        completionHandler(true, JSON(["":""]), nil)
                        return;
                    }
                    
                    let httpStatus = (response.response != nil) ? response.response!.statusCode : ((error as NSError?)?.code ?? 0)
                    print(httpStatus)
                    var parms : [String : Any] = ["StatusCode" : httpStatus]
                    if let data = response.data {
                        if let utf8Text = try? JSONSerialization.jsonObject(with: data, options: []) , utf8Text is [String : Any]  {
                            for (key, value) in utf8Text as! [String : Any]{// For error parms
                                parms[key] = value
                            }
                        }
                    }
                    
                    if  let _ = error as NSError? {
                        
                        if httpStatus == 13 {
                            apiError = NSError(domain: "Check your internet connection", code: httpStatus, userInfo: parms)
                        }else if(httpStatus == 500){
                            apiError = NSError(domain: "Internal Server Error", code: httpStatus, userInfo: parms)
                        }else{
                            apiError = NSError(domain: error.errorDescription ?? "", code: httpStatus, userInfo: parms)
                        }
                      }
                    print(error.errorDescription!)
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
