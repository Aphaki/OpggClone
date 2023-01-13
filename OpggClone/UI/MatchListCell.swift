//
//  MatchListCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/12.
//

import SwiftUI

struct MatchListCell: View {
    
    var matchInfo: MatchInfo
    var participant: Participant
    
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
                    AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(participant.championName).png")) { img in
                        img
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    VStack {
//                        Image()
                    }
                }
            }
            Spacer()
        }
    }
}

struct MatchListCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchListCell(matchInfo: myPreviewClass.matchInfo, participant: myPreviewClass.matchInfo.info.participants.first!)
    }
}
