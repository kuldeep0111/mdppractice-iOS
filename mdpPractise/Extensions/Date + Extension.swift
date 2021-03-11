//
//  Date + Extension.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/03/21.
//

import Foundation


func currentDate() -> String {
    let currentDate = Date()
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    
    var day = "\(currentDate.day)"
    var month = "\(currentDate.month)"
    if day.count == 1 {
        day = "0\(day)"
    }
    if(month.count == 1){
        month = "0\(month)"
    }
    let formatedDate = "\(day)/\(month)/\(currentDate.year)"
    return formatedDate
}


extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date: Date? = dateFormatter.date(from: self)
        return date
    }
}
