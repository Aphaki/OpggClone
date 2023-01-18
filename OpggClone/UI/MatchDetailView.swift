//
//  MatchDetailView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import SwiftUI

struct MatchDetailView: View {
    
    
    var body: some View {
        VStack {
            Text("탭 뷰 구성")
            Divider()
            Text("스크롤뷰")
            Text("해당 소환사 성적")
            Text("참여자 개인 성적")
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView()
    }
}
