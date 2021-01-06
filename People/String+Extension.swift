//
//  String+Extension.swift
//  People
//
//  Created by Nishant Taneja on 07/01/21.
//

import Foundation

extension String {
    var isPhoneNumber: Bool {
            do {
                let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
                let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
                if let res = matches.first {
                    return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count == 10
                } else {
                    return false
                }
            } catch {
                return false
            }
        }
}
