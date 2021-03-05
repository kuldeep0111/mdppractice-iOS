//
//  AuthenticationModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/03/21.
//

//import UIKit
//import Foundation
//import Sugar
//import Tailor
//
//class GiveIndiaCauses: NSObject,Mappable {
//
//    struct giveindiacauseKey{
//        static let errorCodeKey = "error_code"
//        static let errorMessageKey = "error_message"
//        static let prospectIdkey = "prospectid"
//        static let usertypeKey = "usertype"
//    }
//
//    var errorCode: String = ""
//    var errorMessage: String = ""
//    var prospectID: Int?
//    var userType: String = ""
//
//    required convenience init(_ map: JSONDictionary) {
//        self.init()
//        errorCode            <- map.property(giveindiacauseKey.errorCodeKey)
//        errorMessage            <- map.property(giveindiacauseKey.errorMessageKey)
//        prospectID          <- map.property(giveindiacauseKey.prospectIdkey)
//        userType         <- map.property(giveindiacauseKey.usertypeKey)
//    }
//
//    override init() {
//
//    }
//}
