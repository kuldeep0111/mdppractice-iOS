//
//  ClinicListModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class ClinicListModel: NSObject,Mappable {

    struct clinicListModelKey{
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
    }

    var cell: String = ""
    var city: String = ""
    var clinic: String = ""
    var clinicID: Int?
    var email: String = ""
    var clinicName: String = ""
    var primaryClinic: String = ""
    var refCode: String = ""
    var status: String = ""
    var pinCode: String = ""
    required convenience init(_ map: JSONDictionary) {
        self.init()
        cell            <- map.property(clinicListModelKey.cellKey)
        city            <- map.property(clinicListModelKey.cityKey)
        clinic          <- map.property(clinicListModelKey.clinickey)
        clinicID        <- map.property(clinicListModelKey.clinicidKey)
        clinicName      <- map.property(clinicListModelKey.nameKey)
        email           <- map.property(clinicListModelKey.emailKey)
        primaryClinic   <- map.property(clinicListModelKey.primaryKey)
        refCode         <- map.property(clinicListModelKey.refCodeKey)
        status          <- map.property(clinicListModelKey.statusKey)
        pinCode         <- map.property(clinicListModelKey.pinCodeKey)
    }

    override init() {

    }
}
