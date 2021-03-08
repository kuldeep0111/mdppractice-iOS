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
    
    var UpcomingAppointmentList : [AppointmentListModel] = []
    var BlockAppointmentList : [AppointmentListModel] = []
    
    func AppointmentList(completionHandler: ((Bool, _ user: JSON?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "list_appointment"
        params["providerid"] = providerID
        params["clinicid"]    = selectedClinic?.clinicID
        params["from_date"] = currentDate()
        
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.AppointmentList), action: .post, params: params) { [self] (successful, response, error) in
            
            var AppointmentList : [AppointmentListModel] = []
            
            if successful {
                if let array = response["apptlist"].arrayObject{
                       
                    for item in array {
                        AppointmentList.append(AppointmentListModel(item as! JSONDictionary))
                    }
                    
                    for item in AppointmentList {
                        print(item.status)
                        if(item.status == "Confirmed"){
                            self.UpcomingAppointmentList.append(item)
                        }else{
                            self.BlockAppointmentList.append(item)
                        }
                    }
                    print(UpcomingAppointmentList.count)
                    print(BlockAppointmentList.count)
                }
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
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
