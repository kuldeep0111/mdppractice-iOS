//
//  TreatmentDetails.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 15/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor


//maxcount = 0;
//next = 1;
//page = 0;
//prev = 1;
//result = success;
//runningcount = 0;
//treatmentcount = 0;


class TreatmentModel: NSObject, Mappable {
    
    var result: String = ""
    var maxCount: Int?
    var page: Int?
    var next: Int?
    var prev: Int?
    var runningCount: Int?
    var treatmentCount: Int?
    var treatmentList : [TreatmentDetails] = []
    var treatmentYear: String = ""
    required convenience init(_ map: JSONDictionary) {
        self.init()
        result        <- map.property("result")
        maxCount      <- map.property("maxcount")
        next          <- map.property("next")
        page          <- map.property("page")
        prev      <- map.property("prev")
        runningCount    <- map.property("runningcount")
        treatmentCount   <- map.property("treatmentcount")
        treatmentYear  <- map.property("treatmentyear")
        treatmentList      <- map.relations("treatmentlist")
        //        dateString <- map.property(doctorModelKey.dateKey)
    }
    override init() {
        
    }
    
}


class TreatmentDetails: NSObject,Mappable{
    var status: String = ""
    var totalDue: Int?
    var totalPay: Int?
    var dateString: String = ""
    var docName: String = ""
    var clinicID: String = ""
    var clinicName: String = ""
    var patientName: String = ""
    var totalIndpays: String = ""
    var doctorID: String = ""
    var totalTreatmentCost: Int?
    var treatment: String = ""
    var treatmentID: String = ""
    var treatmentDate: Date = Date()
    required convenience init(_ map: JSONDictionary) {
        self.init()
        status        <- map.property("status")
        totalDue      <- map.property("totaldue")
        totalPay      <- map.property("totalcopay")
        docName       <- map.property("doctorname")
        clinicID      <- map.property("clinicid")
        clinicName    <- map.property("clinicname")
        patientName   <- map.property("patientname")
        totalIndpays  <- map.property("totalinspays")
        doctorID      <- map.property("doctorid")
        totalTreatmentCost   <- map.property("totaltreatmentcost")
        treatment     <- map.property("treatment")
        treatmentID   <- map.property("treatmentid")
        treatmentDate <- map.transform("treatmentdate", transformer: { (value: String) -> Date? in
            return value.toDate(dateFormat: "dd/MM/yyyy")
        })
        //        dateString <- map.property(doctorModelKey.dateKey)
    }
    override init() {
        
    }
}

