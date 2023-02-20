//
//  IngameMatchInfoLoadingView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/19.
//

import SwiftUI

struct IngameMatchInfoLoadingView: View {
    
    @Binding var spectator: Spectator?
    
    var body: some View {
        if spectator == nil {
            ProgressView()
        } else {
            InGameMatchInfoView(spectator: spectator!)
        }
    }
}

struct IngameMatchInfoLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        IngameMatchInfoLoadingView(spectator: .constant(myPreviewClass.spectator))
    }
}
