//
//  DealtBar.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/19.
//

import SwiftUI

struct DealtBar: View {
    
    let maxDealt: Int
    let dealt: Int
    
    let teamId: Int
    
    private var portion: CGFloat {
        let value = CGFloat(dealt) / CGFloat(maxDealt)
        return value
    }
    
    var body: some View {
        Text("\(dealt.withKString())")
            .frame(height: 15)
            .frame(maxWidth: 50)
            .font(.caption)
            .foregroundColor(.white)
            .background(
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.gray)
                    RoundedRectangle(cornerRadius: 5).foregroundColor(teamId == 100 ? Color.myColor.lightBlue : Color.myColor.red)
                        .frame(width: 50 * portion)
                }
                 )
    }
}

struct DealtBar_Previews: PreviewProvider {
    static var previews: some View {
        DealtBar(maxDealt: myPreviewClass.maxDealt, dealt: 8392, teamId: 100)
    }
}
