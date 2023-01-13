//
//  MatchListCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/12.
//

import SwiftUI

struct MatchListCell: View {
    
    var matchInfo: MatchInfo
    
    var body: some View {
        HStack {
            VStack {
                Text("승")
                Divider()
                Text("42:38")
            }
            .font(.caption)
            .frame(maxWidth: 40, maxHeight: 130)
            .background(Color.myColor.mylightBlue)
            .foregroundColor(.white)
            HStack {
                HStack {
                 Image("Xerath_0")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    VStack {
                        Image("")
                    }
                }
            }
            Spacer()
        }
    }
}

struct MatchListCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchListCell(matchInfo: myPreviewClass.matchInfo)
    }
}
