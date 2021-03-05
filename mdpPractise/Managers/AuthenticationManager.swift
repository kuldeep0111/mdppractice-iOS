//
//  AuthenticationManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/03/21.
//

import Foundation
import Sugar
import SwiftyJSON

class AuthenticationManager: APIManager {
    
    override class var sharedInstance: AuthenticationManager {
        struct Static {
            static let instance: AuthenticationManager = AuthenticationManager()
        }
        return Static.instance
    }
    
    func login(_ mobile: String,completionHandler: ((Bool, _ userType: Int?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["cell"]    = mobile.trim()
        params["action"]       = "otp_login"
        print(params)
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.UserLogin), action: .post, params: params) { (successful, response, error) in
            
            var userType = 0
            
            if successful {
                
                if let dict = response.dictionaryObject {
                    let prospectid = (dict["prospectid"] as? NSString)?.intValue
                    let clinicCount = (dict["clinic_count"] as? NSString)?.intValue
                    if(response["usertype"] == "prospect" && prospectid == 0) {
                        userType = 2
                    }else if(response["usertype"] == "prospect" && prospectid! > 0){
                        
                        //if let count =  clinicCount {
                        if(clinicCount! > 0){
                            userType = 4
                                print("Case 4")
                            }
                        else{
                            userType = 3
                            print("Case 3")
                        }
                    }
                    else if(dict["providerid"] != nil) {
                       print("case 1")
                        userType = 1
                    }
                }
                
                completionHandler?(true, userType, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
}
