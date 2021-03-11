//
//  AppointmentByMonth.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 09/03/21.
//

import UIKit
import Foundation
import Sugar
import Tailor

class AppointmentByMonthModel: NSObject,Mappable {
    
    struct doctorModelKey{
        static let countKey = "count"
        static let dateKey = "apptdate"
    }
    
    var date: Date = Date()
    var count: Int?
    
    required convenience init(_ map: JSONDictionary) {
        self.init()
        count        <- map.property(doctorModelKey.countKey)
        date                <- map.transform(doctorModelKey.dateKey, transformer: { (value: String) -> Date? in
            return value.toDate(dateFormat: "dd/MM/yyyy")
        })
    }
    override init() {

    }
}
