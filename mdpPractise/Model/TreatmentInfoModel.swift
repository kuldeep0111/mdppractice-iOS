//
//  TreatmentInfoModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 15/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class TreatmentInfoModel: NSObject,Mappable{
    var status: String = ""
    var totalDue: Int?
    var totalPay: Int?
    var totalInsPay: Int?
    var dateString: String = ""
    var docName: String = ""
    var clinicID: String = ""
    var clinicName: String = ""
    var patientName: String = ""
    var totalIndpays: String = ""
    var doctorID: String = ""
    var totalTreatmentCost: Int?
    var treatment: String = ""
    var treatmentID: Int?
    var treatmentDate: Date = Date()
    var ProcedureList: [ProcedureDetail] = []
    required convenience init(_ map: JSONDictionary) {
        self.init()
        status        <- map.property("status")
        totalDue      <- map.property("totaldue")
        totalPay      <- map.property("totalcopay")
        totalInsPay   <- map.property("totalinspays")
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
        ProcedureList <- map.relations("proclist")
        //        dateString <- map.property(doctorModelKey.dateKey)
    }
    override init() {
        
    }
}

class ProcedureDetail: NSObject,Mappable{
    var status: String = ""
    var copay: Int?
    var inspays: Int?
    var procedureCode: String = ""
    var procedureFee: Int?
    var quadrant: String = ""
    var relgrproc: Int?
    var relgrprocdesc: String = ""
    var relgrtransaction: Int?
    var tooth: String = ""
    var authDescription: String = ""
    var plan: String = ""
    required convenience init(_ map: JSONDictionary) {
        self.init()
        status        <- map.property("status")
        copay      <- map.property("copay")
        inspays      <- map.property("inspays")
        procedureCode       <- map.property("procedurecode")
        procedureFee      <- map.property("procedurefee")
        quadrant    <- map.property("quadrant")
        relgrproc   <- map.property("relgrproc")
        relgrprocdesc  <- map.property("relgrprocdesc")
        relgrtransaction      <- map.property("relgrtransaction")
        tooth     <- map.property("tooth")
        authDescription <- map.property("altshortdescription")
        plan <- map.property("plan")
        //        dateString <- map.property(doctorModelKey.dateKey)
    }
    override init() {
        
    }
}

