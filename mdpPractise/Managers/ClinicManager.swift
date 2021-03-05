//
//  ClinicManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/03/21.
//

import Foundation
import Sugar
import SwiftyJSON

class ClinicManager: APIManager {
    
    override class var sharedInstance: ClinicManager {
        struct Static {
            static let instance: ClinicManager = ClinicManager()
        }
        return Static.instance
    }
    
    func AddNewClinic(prospectedID: String,mobileNo: String,name: String,address1: String,address2: String,city: String,state: String,pin: String,email: String, completionHandler: ((Bool, _ userType: Any?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]    = "new_clinic"
        params["ref_id"] = prospectedID
        params["name"] = name
        params["address1"] = address1
        params["address2"] = address2
        params["city"] = city
        params["st"] = state
        params["pin"] = pin
        params["email"] = email
        params["cell"] = mobileNo
        
       let user = UserDefaults.standard.integer(forKey: "userType")
        if(user == 3){
            params["ref_code"] = "PST"
        }else{
            params["ref_code"] = "PRV"
        }
        
        print(params)
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.NewClinic), action: .post, params: params) { (successful, response, error) in
            
            
            if successful {
                
                if let dict = response.dictionaryObject {
                    print(dict)
                }
                completionHandler?(true, nil, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }

    

}
