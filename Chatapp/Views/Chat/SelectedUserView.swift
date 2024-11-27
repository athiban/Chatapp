//
//  Untitled.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 28/11/24.
//

import SwiftUI
import StreamChatSwiftUI
import StreamChat

struct SelectedUserView: View {

    @Injected(\.colors) var colors

    var user: ChatUser

    var body: some View {
        HStack {
            MessageAvatarView(
                avatarURL: user.imageURL,
                size: CGSize(width: 20, height: 20)
            )

            Text(user.name ?? user.id)
                .lineLimit(1)
                .padding(.vertical, 2)
                .padding(.trailing)
        }
        .background(Color(colors.background1))
        .cornerRadius(16)
    }
}
