//
//  AppointmentByDayModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 11/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class AppointmentByDayModel: NSObject,Mappable {
    
    struct doctorModelKey{
        static let countKey = "count"
        static let dateKey = "apptdate"
    }
    
    var patientID: Int?
    var docMobileNo: String = ""
    var appointmentID: String = ""
    var location: String = ""
    var docName: String = ""
    var clinicRef: String = ""
    var providerID: String = ""
    var notes: String = ""
    var docID: Int?
    var patMobileNo: String = ""
    var clinicID: Int?
    var patientName: String = ""
    var proMobileNo: String = ""
    var status: String = ""
    var memberID: Int?
    var duration: Int?
    var clinicName: String = ""
    var isBlock: Bool = false
    var appointmentDate: Date?
    var appointmentTime: String = ""
    var dateTimeString = ""
    required convenience init(_ map: JSONDictionary) {
        self.init()
        patientID            <- map.property("patientid")
        docMobileNo          <- map.property("doccell")
        appointmentID        <- map.property("appointmentid")
        clinicID             <- map.property("clinicid")
        clinicName           <- map.property("clinic_name")
        location             <- map.property("location")
        docName              <- map.property("docname")
        clinicRef            <- map.property("clinic_ref")
        status          <- map.property("status")
        providerID         <- map.property("providerid")
        notes           <- map.property("notes")
        docID        <- map.property("doctorid")
        patMobileNo        <- map.property("patcell")
        patientName   <- map.property("patientname")
        patientID             <- map.property("patientid")
        memberID            <- map.property("memberid")
        dateTimeString <- map.property("apptdatetime")
        let start = dateTimeString.index(dateTimeString.startIndex, offsetBy: 0)
        let end =  dateTimeString.index(dateTimeString.endIndex, offsetBy: -9)
        let range = start..<end
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        appointmentDate = dateFormatter.date(from:"\(dateTimeString[range])") ?? nil
        print(appointmentDate)
        let start1 = dateTimeString.index(dateTimeString.startIndex, offsetBy: 11)
        let end1 =  dateTimeString.index(dateTimeString.endIndex, offsetBy: 0)
        let range1 = start1..<end1
        appointmentTime = "\(dateTimeString[range1])"
        
    }
    override init() {

    }
}
