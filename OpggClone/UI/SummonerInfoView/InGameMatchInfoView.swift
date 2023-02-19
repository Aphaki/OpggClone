//
//  InGameMatchInfo.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/17.
//

import SwiftUI

struct InGameMatchInfoView: View {
    
    var spectator: Spectator
    
    let queueIdToType = JsonInstance.shared.dicQueueIdAndType
    let queueIdToMap = JsonInstance.shared.dicQueueIdAndMap
    @State var nowTime = Double(Date().timeIntervalSince1970)
    let timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
    
    var blueTeam: [SpParticipant] {
        let totalParticipants =
        spectator.spParticipants
        let blueTeam =
        totalParticipants.filter { aParticipant in
            return aParticipant.teamID == 100
        }
        return blueTeam
    }
    
    var redTeam: [SpParticipant] {
        let totalParticipants =
        spectator.spParticipants
        let redTeam =
        totalParticipants.filter { aParticipant in
            return aParticipant.teamID == 200
        }
        return redTeam
    }
    
    var body: some View {
        
        TabView {
            VStack {
                HStack {
                    Text(queueIdToType[spectator.gameQueueConfigID] ?? "타입")
                        .foregroundColor(Color.myColor.lightBlue)
                    Text(queueIdToMap[spectator.gameQueueConfigID] ?? "맵")
                        .foregroundColor(Color.myColor.accentColor)
                    Spacer()
//                    Text("33:34")
                    Text( (nowTime - Double(spectator.gameStartTime/1000)).unixToMyIngameWatch())
                        .onReceive(timer) { _ in
                            nowTime += 1
                        }
                }.font(.caption)
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 3)
                    .foregroundColor(Color.myColor.accentColor)
                VStack {
                    HStack {
                        Text("블루")
                        Spacer()
                        Text("챔프 스코어")
                        Spacer()
                        Text("레드")
                    }
                    Divider()
                    VStack {
                        
                    }
                }
                Spacer()
            }
            .tabItem {
                Text("팀 정보")
            }
            
            Text("추천 빌드")
                .tabItem {
                    Text("추천 빌드")
                }
        }
        
    }
}


struct InGameMatchInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InGameMatchInfoView(spectator: myPreviewClass.spectator!)
    }
}
