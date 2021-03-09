//
//  ClinicDetailModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 09/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class ClinicDetailModel: NSObject,Mappable {

    struct clinicDetailModelKey{
        static let cellKey = "cell"
        static let cityKey = "city"
        static let clinickey = "clinic"
        static let clinicidKey = "clinicid"
        static let emailKey = "email"
        static let nameKey = "name"
        static let primaryKey = "primary_clinic"
        static let refCodeKey = "ref_code"
        static let statusKey = "status"
        static let pinCodeKey = "pin"
        static let stateKey = "st"
        static let address1Key = "address1"
        static let address2Key = "address2"
        static let dentalChaires = "dentalchairs"
    }

    var cell: String = ""
    var city: String = ""
    var state: String = ""
    var clinic: String = ""
    var clinicID: Int?
    var email: String = ""
    var clinicName: String = ""
    var primaryClinic: String = ""
    var refCode: String = ""
    var status: String = ""
    var pinCode: String = ""
    var address1: String = ""
    var address2: String = ""
    var dentalChaires: String = ""
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        cell            <- map.property(clinicDetailModelKey.cellKey)
        city            <- map.property(clinicDetailModelKey.cityKey)
        clinic          <- map.property(clinicDetailModelKey.clinickey)
        clinicID        <- map.property(clinicDetailModelKey.clinicidKey)
        clinicName      <- map.property(clinicDetailModelKey.nameKey)
        email           <- map.property(clinicDetailModelKey.emailKey)
        primaryClinic   <- map.property(clinicDetailModelKey.primaryKey)
        refCode         <- map.property(clinicDetailModelKey.refCodeKey)
        status          <- map.property(clinicDetailModelKey.statusKey)
        pinCode         <- map.property(clinicDetailModelKey.pinCodeKey)
        state           <- map.property(clinicDetailModelKey.stateKey)
        address1        <- map.property(clinicDetailModelKey.address1Key)
        address2        <- map.property(clinicDetailModelKey.address2Key)
        dentalChaires   <- map.property(clinicDetailModelKey.dentalChaires)
    }

    override init() {

    }
}
