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
    
    func login(_ mobile: String,completionHandler: ((Bool, _ user: JSON?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["cell"]    = mobile.trim()
        params["action"]       = "otp_login"
        print(params)
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.UserLogin), action: .post, params: params) { (successful, response, error) in
                        
            if successful {
                completionHandler?(true, response, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }
}
