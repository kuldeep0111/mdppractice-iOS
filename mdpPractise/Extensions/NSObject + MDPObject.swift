//
//  NSObject + MDPObject.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/03/21.
//

import Foundation

extension NSObject {
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
