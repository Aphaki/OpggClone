//
//  Double.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/07.
//

import Foundation

extension Double {
    private var numFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }
    private var formatterNoDemical: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    func with2Demicals() -> String {
        let num = NSNumber(value: self)
        return numFormatter.string(from: num) ?? "0.00"
    }
    
    func changedPercentage() -> String {
        let num = NSNumber(value: self * 100)
        return formatterNoDemical.string(from: num) ?? "0"
    }
    func asNumberString() -> String {
        return String(format: "%.1f", self)
    }

}
