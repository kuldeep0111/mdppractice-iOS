//
//  TreatmentManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 15/03/21.
//

import Foundation

class TreatmentManager: APIManager {
    
    override class var sharedInstance: TreatmentManager {
        struct Static {
            static let instance: TreatmentManager = TreatmentManager()
        }
        return Static.instance
    }
}

