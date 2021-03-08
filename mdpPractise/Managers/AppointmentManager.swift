//
//  AppointmentManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/03/21.
//

import Foundation
import Sugar
import SwiftyJSON

class AppointmentManager: APIManager {
    
    override class var sharedInstance: AppointmentManager {
        struct Static {
            static let instance: AppointmentManager = AppointmentManager()
        }
        return Static.instance
    }
    
    
    func NewAppointment(mobile: String, providerID: String,name: String, email: String,gender: String,dob: String,completionHandler: ((Bool, _ user: JSON?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "new_appointment"
        params["providerid"] = providerID
        params["memberid"] = "12"
        params["cell"]    = mobile.trim()
        params["patientid"] = name
        params["complaint"] = email
        params["appointment_start"] = dob
        params["duration"] = gender
        params["notes"] =
        
        print(params)
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.NewAppointment), action: .post, params: params) { (successful, response, error) in
            
            if successful {
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    
}
