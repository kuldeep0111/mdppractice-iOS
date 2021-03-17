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

extension Date {
    
    static func dateFromFormatDDMMYYYY(_ date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: date)
    }
}


extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date: Date? = dateFormatter.date(from: self)
        return date
    }
    
    func timeFormate24Hrs() -> String{
        let dateAsString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateAsString)

        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        return date24
    }
}
