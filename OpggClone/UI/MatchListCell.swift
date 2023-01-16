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
    let spellDictionary = InstanceOfSummonerSpell.instance.spellDictionary
    
    
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
                HStack(spacing: 3) {
                    AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(participant.championName).png")) { img in
                        img
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(spacing: 2) {
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary["1"] ?? "SummonerTeleport").png")) { img in
                            img
                                .resizable()
                                .frame(width: 20, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary["2"] ?? "SummonerFlash").png")) { img in
                            img
                                .resizable()
                                .frame(width: 20, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
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
            .preferredColorScheme(.dark)
    }
}
