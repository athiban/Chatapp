//
//  SplashView.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct SplashView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
        
    var body: some View {
        ZStack {
           
        }
        .background(Color.customBlack)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.spring()) {
                    if AuthManager.shared.loggedIn {
                        let _ = StreamManager.shared
                        appRootManager.currentRoot = .home
                    }
                    else {
                        appRootManager.currentRoot = .authentication
                    }
                }
            }
        }
    }
}
