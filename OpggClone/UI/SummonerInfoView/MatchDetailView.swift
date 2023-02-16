//
//  MatchDetailView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import SwiftUI

struct MatchDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var matchInfo: MatchInfo
    
    var summonerInfo: SummonerInfo
    
    private var selectedSummoner: Participant {
        let value = matchInfo.info.participants.first { participant in
            return participant.puuid == summonerInfo.puuid
        }
        return value!
    }
    
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
                HStack {
                    AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(selectedSummoner.championName).png")) { img in
                        img
                            .resizable()
                            .frame(width: 45, height: 45)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Text(selectedSummoner.championName)
                        Text("\(selectedSummoner.teamPosition)")
                            .font(.caption)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(selectedSummoner.kills)")
                            Text("/")
                            Text("\(selectedSummoner.deaths)")
                                .foregroundColor(Color.myColor.red)
                            Text("/")
                            Text("\(selectedSummoner.assists)")
                        }
                        Text("킬 관여 \(selectedSummoner.challenges?["killParticipation"]?.changedPercentage() ?? "0")%")
                            .font(.caption)
                    }
                }
                .padding()
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(selectedSummoner.teamID == winTeamId
                                     ? Color.myColor.darkBlue.opacity(0.5) : Color.myColor.red.opacity(0.5))
                )
                HStack(spacing: 3) {
                    Text("승리")
                        .foregroundColor(Color.myColor.lightBlue)
                    Text(winTeamId == 100 ? "(블루)" : "(레드)")
                    if winTeamId == 100 {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[0].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[1].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.red)
                            Text("/")
                            Text("\(blueTeamAssist)")
                        }
                    } else {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[1].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[0].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.red)
                            Text("/")
                            Text("\(redTeamAssist)")
                        }
                    }
                    Spacer()
                    HStack(spacing: 2) {
                        Text("바론")
                        Text(winTeamId == 100 ? "\(matchInfo.info.teams[0].objectives.baron.kills)" : "\(matchInfo.info.teams[1].objectives.baron.kills)")
                        Text("드래곤")
                        Text(winTeamId == 100 ? "\(matchInfo.info.teams[0].objectives.dragon.kills)" : "\(matchInfo.info.teams[1].objectives.dragon.kills)")
                        Text("포탑")
                        Text(winTeamId == 100 ? "\(matchInfo.info.teams[0].objectives.tower.kills)" : "\(matchInfo.info.teams[1].objectives.tower.kills)")

                    }
                    .font(.caption)
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
                        .foregroundColor(Color.myColor.red)
                    Text(winTeamId == 100 ? "(레드)" : "(블루)")
                    if winTeamId == 200 {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[0].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[1].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.red)
                            Text("/")
                            Text("\(blueTeamAssist)")
                        }
                    } else {
                        HStack(spacing: 2) {
                            Text("  \(matchInfo.info.teams[1].objectives.champion.kills)")
                            Text("/")
                            Text("\(matchInfo.info.teams[0].objectives.champion.kills)")
                                .foregroundColor(Color.myColor.red)
                            Text("/")
                            Text("\(redTeamAssist)")
                        }
                    }
                    Spacer()
                    HStack(spacing: 2) {
                        Text("바론")
                        Text(winTeamId == 100 ? "\(matchInfo.info.teams[1].objectives.baron.kills)" : "\(matchInfo.info.teams[0].objectives.baron.kills)")
                        Text("드래곤")
                        Text(winTeamId == 100 ? "\(matchInfo.info.teams[1].objectives.dragon.kills)" : "\(matchInfo.info.teams[0].objectives.dragon.kills)")
                        Text("포탑")
                        Text(winTeamId == 100 ? "\(matchInfo.info.teams[1].objectives.tower.kills)" : "\(matchInfo.info.teams[0].objectives.tower.kills)")

                    }
                    .font(.caption)
                    
                }
                Divider()
                ForEach(winTeamId==100 ? redTeamMembers : blueTeamMembers) { participant in
                    MatchDetailCell(participant: participant, matchInfo: matchInfo, summonerInfo: summonerInfo)
                    Divider()
                }
            }
            .padding(10)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }

            }
        }
        
        
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(matchInfo: myPreviewClass.matchInfo, summonerInfo: myPreviewClass.summoner)
    }
}
