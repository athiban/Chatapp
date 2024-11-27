//
//  CustomChatChannelHeader.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//
import SwiftUI
import StreamChatSwiftUI
import StreamChat
import Kingfisher

struct CustomChatChannelHeader: ToolbarContent {

    var channel: ChatChannel
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text(channel.lastActiveMembers.filter({$0.id != AuthManager.shared.getUser()?.userID}).first?.name ?? "")
                    .foregroundStyle(Color.white)
                    .font(.custom("FiraCode-Bold", size: 15))
                Text(((channel.lastActiveMembers.filter({$0.id != AuthManager.shared.getUser()?.userID}).first?.isOnline ?? false) ? "Online" : "Last seen " + (channel.lastActiveMembers.filter({$0.id != AuthManager.shared.getUser()?.userID}).first?.lastActiveAt?.asString(withFormat: "hh:mm a MMM dd, yyyy") ?? "")))
                    .foregroundStyle(Color.gray)
                    .font(.custom("FiraCode-Medium", size: 11))
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            KFImage(channel.lastActiveMembers.filter({$0.id != AuthManager.shared.getUser()?.userID}).first?.imageURL)
                .resizable()
                .frame(width: 30, height: 30)
                .scaledToFit()
                .cornerRadius(20)
        }
    }
}

struct CustomChatChannelModifier: ChatChannelHeaderViewModifier {

    var channel: ChatChannel

    func body(content: Content) -> some View {
        ZStack {
            content.toolbar {
                CustomChatChannelHeader(channel: channel)
            }
            .toolbarBackground(Color.customBlack, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarRole(.editor)
        }
        .background(Color.customBlack)
    }
}

