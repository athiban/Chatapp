//
//  ChatappApp.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import SwiftUI
import StreamChatSwiftUI

@main
struct ChatappApp: App {
    
    @StateObject private var appRootManager = AppRootManager()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .splash: SplashView()
                case .authentication: LoginView()
                case .home: ChatChannelListView(viewFactory: CustomFactory.shared, title: "Connections")
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
