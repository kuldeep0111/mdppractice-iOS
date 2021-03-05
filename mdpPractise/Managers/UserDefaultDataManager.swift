//
//  UserDefaultDataManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/03/21.
//

import Foundation
import SwiftyJSON
import Sugar

class UserDefaultManager {
    struct PropertyKey {
        static let tokenKey = "tokenKey"
    }
    
    class var sharedInstance: UserDefaultManager {
        struct Static {
            static let instance: UserDefaultManager = UserDefaultManager()
        }
        return Static.instance
    }
}

extension UserDefaultManager {
    
    //Auth Token
    func save(_ token: String) -> Bool {
         UserDefaults.standard.set(token, forKey: PropertyKey.tokenKey)
        return true
    }
    
    func token() -> String? {
       let token = UserDefaults.standard.string(forKey: PropertyKey.tokenKey)
        if token != nil {
            return token
        } else {
            return nil
        }
    }
    
    func deleteToken() -> Bool {
        UserDefaults.standard.removeObject(forKey: PropertyKey.tokenKey)
        return true
    }
}
