//
//  MatchDetailView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import SwiftUI

struct MatchDetailView: View {
    
    var matchInfo: MatchInfo
    
    var summonerInfo: SummonerInfo
    
    private var blueTeamMembers: [Participant] {
       let value = matchInfo.info.participants.filter { participant in
            participant.teamID == 100
        }
        return value
    }
    private var blueTeamAssist: Int {
        let assistArray = blueTeamMembers.map { member in
           return member.assists
        }
        let value = assistArray.reduce(0, +)
        return value
    }
    private var redTeamMembers: [Participant] {
        let value = matchInfo.info.participants.filter { participant in
             participant.teamID == 200
         }
         return value
    }
    private var redTeamAssist: Int {
        let assistArray = redTeamMembers.map { member in
           return member.assists
        }
        let value = assistArray.reduce(0, +)
        return value
    }
    private var winTeamId: Int {
       let value = matchInfo.info.teams.first { team in
            return team.win
        }
        return value!.teamID
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                HStack(spacing: 3) {
                    Text("승리")
                        .foregroundColor(Color.myColor.mylightBlue)
                    Text(winTeamId == 100 ? "(블루)" : "(레드)")
                    if winTeamId == 100 {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[0].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[1].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.myRed)
                            Text("/")
                            Text("\(blueTeamAssist)")
                        }
                    } else {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[1].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[0].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.myRed)
                            Text("/")
                            Text("\(redTeamAssist)")
                        }
                    }
                    Spacer()
                    HStack {
                        Text("바론")
                            .font(.caption)
                        Text(winTeamId == 100 ? "\(0)" : "")
                        Text("드")
                    }
                }
                Divider()
                ForEach(winTeamId==100 ? blueTeamMembers : redTeamMembers) { participant in
                    MatchDetailCell(participant: participant, matchInfo: matchInfo, summonerInfo: summonerInfo)
                    Divider()
                }
            }
            .padding(10)
            VStack(spacing: 5) {
                HStack(spacing: 3) {
                    Text("패배")
                        .foregroundColor(Color.myColor.myRed)
                    Text(winTeamId == 100 ? "(레드)" : "(블루)")
                    if winTeamId == 200 {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[0].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[1].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.myRed)
                            Text("/")
                            Text("\(blueTeamAssist)")
                        }
                    } else {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[1].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[0].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.myRed)
                            Text("/")
                            Text("\(redTeamAssist)")
                        }
                    }
                    Spacer()
                    
                    
                }
                Divider()
                ForEach(winTeamId==100 ? redTeamMembers : blueTeamMembers) { participant in
                    MatchDetailCell(participant: participant, matchInfo: matchInfo, summonerInfo: summonerInfo)
                    Divider()
                }
            }
            .padding(10)
        }
        
        
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(matchInfo: myPreviewClass.matchInfo, summonerInfo: myPreviewClass.summoner)
    }
}
