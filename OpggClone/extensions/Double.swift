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
    
    func unixToMyString() -> String {
        let unixTime = self
        let myYears = unixTime / 60 / 60 / 24 / 30 / 12
        let myMonths = unixTime / 60 / 60 / 24 / 30
        let myDays =  unixTime / 60 / 60 / 24
        let myHours =  unixTime / 60 / 60
        let myMinutes =  unixTime / 60
        if myYears > 50 {
            return "오래전"
        } else if myYears > 1 {
            return "\(Int(myYears))년전"
        } else if myMonths > 1 {
            return "\(Int(myMonths))달전"
        } else if myDays > 1 {
            return "\(Int(myDays))일전"
        } else if myHours > 1 {
            return "\(Int(myHours))시간전"
        } else if myMinutes > 1 {
            return "\(Int(myMinutes))분전"
        } else {
            return "\(Int(unixTime))초전"
        }
    }
    func unixToMyIngameWatch() -> String {
        let unixTime = Int(self)
        let myMinutes = unixTime / 60
        let mySeconds = unixTime % 60
        if mySeconds < 10 {
            return "\(myMinutes):0\(mySeconds)"
        } else {
            return "\(myMinutes):\(mySeconds)"
        }
    }
}
    

