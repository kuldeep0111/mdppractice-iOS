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

class PatientListModel: NSObject,Mappable{
    
    var name: String = ""
    var dob: String = ""
    var gender: String = ""
    var patientID: Int?
    var email: String = ""
    var phoneNo: String = ""
    var patientMember: String = ""
    var memberID: Int?
    var isMember: Bool = false
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        name <- map.property("fname")
        dob  <- map.property("dob")
        gender <- map.property("gender")
        patientID <- map.property("patientid")
        email <- map.property("email")
        phoneNo <- map.property("cell")
        patientMember <- map.property("patientmember")
        memberID <- map.property("memberid")
        isMember <- map.property("member")
    }
    
    override init() {
        
    }
}



class PatientDetails: NSObject,Mappable{
    
    var profile: PatientProfile?
    var contacts: PatientContact?
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        profile <- map.relation("profile")
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
        name <- map.property("fname ")
        dob  <- map.property("dob ")
        gender <- map.property("gender ")
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
        email <- map.property("email ")
        phoneNo <- map.property("cell ")
    }
    
    override init() {
        
    }
}
