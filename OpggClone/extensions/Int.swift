//
//  Int.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import Foundation

extension Int {
//    private var kFormatter: NumberFormatter {
//        let formatter = NumberFormatter()
//        formatter.minimumFractionDigits = 1
//        formatter.maximumFractionDigits = 1
//        return formatter
//    }
    func toIconImgURL() -> URL? {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/profileicon/\(self).png")
    }
    
    
    func withKString() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return Double(self).asNumberString()
            
        default:
            return "\(sign)\(self)"
        }
    }
}
