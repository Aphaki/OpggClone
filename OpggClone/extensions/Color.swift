//
//  Color.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/12.
//

import Foundation
import SwiftUI

extension Color {
    static let myColor = CustomColor()
}

struct CustomColor {
    let accentColor = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let appBG = Color("AppBG")
    let secondary = Color("Secondary")
    let lightBlue = Color("LightBlue")
    let darkBlue = Color("DarkBlue")
    let black = Color("Black")
    let gray = Color("Gray")
    let red = Color("Red")
}
