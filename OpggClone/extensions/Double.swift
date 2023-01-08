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
    
    func with2Demicals() -> String {
        let num = NSNumber(value: self)
        return numFormatter.string(from: num) ?? "0.00"
    }
}
