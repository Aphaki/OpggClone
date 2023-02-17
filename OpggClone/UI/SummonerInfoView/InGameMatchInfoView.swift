//
//  InGameMatchInfo.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/17.
//

import SwiftUI

struct InGameMatchInfoView: View {
    
    var spectator: Spectator?
    
    var body: some View {
        if spectator != nil {
            TabView {
                VStack {
                    HStack {
                        Text("개인/2인 랭크")
                        Text("소환사의 협곡")
                        Text("33:34")
                        Spacer()
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
            
        } else {
            Text("데이터 없음")
        }
    }
}

struct InGameMatchInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InGameMatchInfoView(spectator: myPreviewClass.spectator)
    }
}
