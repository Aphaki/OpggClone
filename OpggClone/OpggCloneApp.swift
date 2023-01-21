//
//  OpggCloneApp.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

@main
struct OpggCloneApp: App {
    
    @StateObject private var vm = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
        }
    }
}
