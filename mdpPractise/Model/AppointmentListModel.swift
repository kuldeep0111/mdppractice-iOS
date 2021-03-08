//
//  AppointmentListModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class AppointmentListModel: NSObject,Mappable {

    struct appointmentListModelKey{
        static let appointmentidKey = "appointmentid"
        static let apptdatetime = "apptdatetime"
        static let blockkey = "blockkey"
        static let clinicNameKey = "clinic_name"
        static let clinicRefKey = "clinic_ref"
        static let clinicidKey = "clinicid"
        static let refCodeKey = "ref_code"
        static let colorKey = "color"
        static let complaintKey = "complaint"
        static let doccellKey = "doccell"
        static let statusKey = "status"
        static let docnameKey = "docname"
        static let doctoridKey = "doctorid"
        static let durationKey = "duration"
        static let memberidKey = "memberid"
        static let notesKey = "notes"
        static let patcellKey = "patcell"
        static let patientidKey = "patientid"
        static let patientnameKey = "patientname"
        static let provcellKey     = "provcell"
        static let provideridKey = "providerid"
        static let resultKey      = "result"
    }

    var appointmentID: String = ""
    var appointmentTime: String = ""
    var block: String = ""
    var clinicID: Int?
    var clinicName: String = ""
    var clinicRef: String = ""
    var color: String = ""
    var complaint: String = ""
    var docMobileNo: String = ""
    var docname: String = ""
    var doctorid: String = ""
    var duration: String = ""
    var memberid: String = ""
    var notes: String = ""
    var patMobileNo: String = ""
    var patientid: String = ""
    var patientname: String = ""
    var provMobileNo: String = ""
    var providerid: String = ""
    var result: String = ""
    var status: String = ""
    
        
    required convenience init(_ map: JSONDictionary) {
        self.init()
        appointmentID            <- map.property(appointmentListModelKey.appointmentidKey)
        appointmentTime            <- map.property(appointmentListModelKey.apptdatetime)
        block          <- map.property(appointmentListModelKey.blockkey)
        clinicID        <- map.property(appointmentListModelKey.clinicidKey)
        clinicName      <- map.property(appointmentListModelKey.clinicidKey)
        clinicRef           <- map.property(appointmentListModelKey.clinicRefKey)
        color   <- map.property(appointmentListModelKey.colorKey)
        complaint         <- map.property(appointmentListModelKey.complaintKey)
        docMobileNo          <- map.property(appointmentListModelKey.doccellKey)
        docname            <- map.property(appointmentListModelKey.docnameKey)
        doctorid            <- map.property(appointmentListModelKey.doctoridKey)
        duration          <- map.property(appointmentListModelKey.durationKey)
        memberid        <- map.property(appointmentListModelKey.memberidKey)
        notes      <- map.property(appointmentListModelKey.notesKey)
        patMobileNo           <- map.property(appointmentListModelKey.patcellKey)
        patientid   <- map.property(appointmentListModelKey.patientidKey)
        patientname         <- map.property(appointmentListModelKey.patientnameKey)
        provMobileNo        <- map.property(appointmentListModelKey.provcellKey)
        providerid   <- map.property(appointmentListModelKey.provideridKey)
        result         <- map.property(appointmentListModelKey.resultKey)
        status        <- map.property(appointmentListModelKey.statusKey)
    }

    override init() {

    }
}
