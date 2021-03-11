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
    
    func AppointmentList(completionHandler: ((Bool, _ user: [AppointmentListModel]?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "list_appointment"
        params["providerid"] = providerID
        params["clinicid"]    = selectedClinic?.clinicID
        params["from_date"] = currentDate() + " 00:00"
        
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.AppointmentList), action: .post, params: params) { [self] (successful, response, error) in
            
            var AppointmentList : [AppointmentListModel] = []
            
            if successful {
                if let array = response["apptlist"].arrayObject{
                    UpcomingAppointmentList.removeAll()
                    BlockAppointmentList.removeAll()
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
                completionHandler?(true, BlockAppointmentList, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }

    
    
    func NewAppointment(patientID: String,appointmentStart: String,name: String, reason: String,doctorID: String,completionHandler: ((Bool, _ user: JSON?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "new_appointment"
        params["providerid"] = "\(String(describing: providerID!))"
        params["doctorid"] = doctorID
        params["patientid"] = "1"
        params["clinicid"] = "\(String(describing: selectedClinic!.clinicID!))"
        params["memberid"] = "001"
        params["cell"]    = UserDefaults.standard.string(forKey: "cell")
        params["complaint"] = reason
        params["duration"] = 30
        params["appointment_start"] = appointmentStart
        
//        {
//        "action":"new_appointment",
//        "providerid":"1339",
//        "doctorid":"26",
//        "clinicid":"113",
//        "memberid":"001",
//        "patientid":"1",
//        "cell":"6361334930",
//        "complaint":"abc",
//        "appointment_start":"2/3/2021 10:00",
//        "duration":30
//        }
        
        
        let _ =  makeRequest(apiURL(APIEndPoint.NewAppointment), action: .post, params: params) { (successful, response, error) in
            
            if successful {
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    
    
    func AcceptAppointment(appointmentID: String?,completionHandler: ((Bool, _ user: JSON?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "confirm_appointment"
        params["providerid"] = providerID
        params["appointmentid"] = appointmentID
        
        let _ =  makeRequest(apiURL(APIEndPoint.AcceptAppointment), action: .post, params: params) {(successful, response, error) in
                        
            if successful {
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    
    func RejectAppointment(appointmentID: String?,completionHandler: ((Bool, _ user: JSON?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "cancel_appointment"
        params["providerid"] = providerID
        params["appointmentid"] = appointmentID
        
        let _ =  makeRequest(apiURL(APIEndPoint.CancelAppointment), action: .post, params: params) {(successful, response, error) in
                        
            if successful {
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    
    func doctorList(clinicID: Int?,completionHandler: ((Bool, _ user: [DoctorModel]?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "list_doc_clinic"
        params["clinicid"] = clinicID
        params["ref_code"] = "DOC"
        let _ =  makeRequest(apiURL(APIEndPoint.doctorList), action: .post, params: params) {(successful, response, error) in
            
            var doctorList : [DoctorModel] = []
            
            if successful {
                if let array = response["doclist"].arrayObject{
                    for item in array {
                        doctorList.append(DoctorModel(item as! JSONDictionary))
                    }
                    print(array)
                }
                completionHandler?(true, doctorList, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    
    func AppointmentByMonth(month: Int?,year: Int?,clinicID: Int?,completionHandler: ((Bool, _ user: [AppointmentByMonthModel]?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        
        params["action"]  = "list_appointment_count_bymonth"
        params["month"] = month
        params["year"] = year
        params["providerid"] = providerID
        params["clinicid"] = clinicID
        
        let _ =  makeRequest(apiURL(APIEndPoint.AppointmentByMonth), action: .post, params: params) {(successful, response, error) in
            
            var aptDateByMonthList : [AppointmentByMonthModel] = []
            
            if successful {
                aptDateByMonthList.removeAll()
                if let array = response["apptlist"].arrayObject{
                    for item in array {
                        aptDateByMonthList.append(AppointmentByMonthModel(item as! JSONDictionary))
                    }
                }
                completionHandler?(true, aptDateByMonthList, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
}
