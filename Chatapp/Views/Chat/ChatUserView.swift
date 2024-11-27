//
//  ChatUserView.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 28/11/24.
//


import SwiftUI
import StreamChatSwiftUI
import StreamChat

struct ChatUserView: View {

    @Injected(\.fonts) var fonts

    var user: ChatUser
    var onlineText: String

    var body: some View {
        HStack {
            LazyView(
                MessageAvatarView(avatarURL: user.imageURL)
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(user.name ?? user.id)
                    .lineLimit(1)
                    .font(fonts.bodyBold)
                    .foregroundStyle(Color.white)
                Text(onlineText)
                    .font(fonts.footnote)
                    .foregroundColor(.gray)
            }
        }
        .background(Color.customBlack)
    }
}
