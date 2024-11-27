//
//  CustomChannelHeader.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import SwiftUI
import StreamChatSwiftUI
import Kingfisher

public struct CustomChannelListHeader: ToolbarContent {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    
    public var title: String
    
    @Binding var isNewChatShown: Bool
    @State private var showingAlert = false
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.custom("FiraCode-Medium", size: 15))
                .foregroundStyle(.white)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button {
                    isNewChatShown = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .tint(.white)
                        .padding(.all, 8)
                }
                Button {
                    showingAlert = true
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .scaledToFit()
                        .tint(.white)
                        .padding(.all, 4)
                }
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Are you sure you want to logout?"),
                        message: Text(""),
                        primaryButton: .destructive(Text("Logout")) {
                            showingAlert = false
                            AuthManager.shared.logout()
                            StreamManager.shared.streamChat = nil
                            appRootManager.currentRoot = .authentication
                        },
                        secondaryButton: .cancel() {
                            showingAlert = false
                        }
                    )
                }
            }
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
            } label: {
                KFImage(AuthManager.shared.getUser()?.profile?.imageURL(withDimension: 30))
                    .cornerRadius(15)
                    .padding()
            }
        }
    }
}

struct CustomChannelModifier: ChannelListHeaderViewModifier {
    
    var title: String
    
    @State private var isNewChatShown = false
    
    func body(content: Content) -> some View {
        ZStack {
            content.toolbar {
                CustomChannelListHeader(title: title, isNewChatShown: $isNewChatShown)
            }
            NavigationLink(isActive: $isNewChatShown) {
                            NewChatView(isNewChatShown: $isNewChatShown)
                        } label: {
                            EmptyView()
                        }
                        .isDetailLink(UIDevice.current.userInterfaceIdiom == .pad)
                        .tint(.white)
        }
        .background(Color.customBlack)
    }
}
