//
//  PatientModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 16/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor


class PatientDetails: NSObject,Mappable{
    
    var profile: PatientProfile?
    var contacts: PatientContact?
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        profile <- map.property("profile")
        contacts <- map.relation("contact")
    }
    
    override init() {
        
    }
}

class PatientProfile: NSObject,Mappable{
    
    var name: String = ""
    var dob: String = ""
    var gender: String = ""
    var patientID: Int?
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        name <- map.property("fname")
        dob  <- map.property("dob")
        gender <- map.property("gender")
        patientID <- map.property("patientid")
    }
    
    override init() {
        
    }
}

class PatientContact: NSObject,Mappable{
    
    var email: String = ""
    var phoneNo: String = ""
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        email <- map.property("email")
        phoneNo <- map.property("cell")
    }
    
    override init() {
        
    }
}
