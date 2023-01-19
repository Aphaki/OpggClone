//
//  Double.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/07.
//

import Foundation

extension Double {
    private var formatterNoDemical: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }
    private var formatterOneDemical: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }
    private var formatterTwoDemical: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }
    
    func with2Demicals() -> String {
        let num = NSNumber(value: self)
        return formatterTwoDemical.string(from: num) ?? "0.00"
    }
    func with1Demical() -> String {
        let num = NSNumber(value: self)
        return formatterOneDemical.string(from: num) ?? "0.0"
    }
    func changedPercentage() -> String {
        let num = NSNumber(value: self * 100)
        return formatterNoDemical.string(from: num) ?? "0"
    }
    func asNumberString() -> String {
        return String(format: "%.1f", self)
    }

}
