//
//  PatientManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 16/03/21.
//

import Foundation


class PatientManager: APIManager {
    
    override class var sharedInstance: PatientManager {
        struct Static {
            static let instance: PatientManager = PatientManager()
        }
        return Static.instance
    }
    
    func NewPatient(name: String,DOB: String,gender: String, email: String,phoneNo: String,completionHandler: ((Bool, _ user: Any?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]  = "newalkinpatient"
        params["providerid"] = "\(String(describing: providerID!))"
        params["title"] = ""
        params["fname"] = name
        params["mname"] = ""
        params["lname"] = ""
        params["gender"] = gender
        params["dob"] = DOB
        params["cell"] = phoneNo
        params["email"] = email
        params["address1"] = ""
        params["address2"] = ""
        params["address3"] = ""
        params["city"] = ""
        params["st"] = ""
        params["pin"] = ""
        
        let _ =  makeRequest(apiURL(APIEndPoint.addPatient), action: .post, params: params) { (successful, response, error) in
            
            if successful {
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    

}
