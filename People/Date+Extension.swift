//
//  Date+Extension.swift
//  People
//
//  Created by Nishant Taneja on 07/01/21.
//

import UIKit

extension Date {
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: self, to: Date())
        let age = ageComponents.year!
        return age
    }
    
    static func age(from dateString: String, with format: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let age = Calendar.current.dateComponents([.year], from: dateFormatter.date(from: dateString)!, to: Date()).year!
        return age
    }
}
