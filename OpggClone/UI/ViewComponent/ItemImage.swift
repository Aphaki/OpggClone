//
//  ItemImage.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/30.
//

import SwiftUI

struct ItemImage: View {
    
    var itemNumber: Int
    let width: CGFloat
    let height: CGFloat
    let mythicItemInt: Int
    
    var body: some View {
        if itemNumber != 0 {
            
            Image(itemNumber.description)
                .resizable()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .overlay {
                    RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 3).foregroundColor(itemNumber == mythicItemInt ? .yellow : .clear)
                }
            
            
        } else {
            Image("7050")
                .resizable()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 7))
        }
    }
}
