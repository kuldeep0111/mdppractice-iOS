//
//  DoctorModel.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class DoctorModel: NSObject,Mappable {
    
    struct doctorModelKey{
        static let clinicKey = "clinic"
        static let clinicidKey = "apptdatetime"
        static let doctornameKey = "doctor"
        static let doctoridKey = "doctorid"
    }
    
    var clinic: String = ""
    var clinicId: Int?
    var doctorName : String = ""
    var doctorID : Int?
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        clinic            <- map.property(doctorModelKey.clinicKey)
        clinicId            <- map.property(doctorModelKey.clinicidKey)
        doctorName          <- map.property(doctorModelKey.doctornameKey)
        doctorID        <- map.property(doctorModelKey.doctoridKey)
    }
    
    override init() {

    }

}
