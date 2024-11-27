//
//  StreamManager.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

class StreamManager {
    
    static let shared = StreamManager()
    
    var chatClient: ChatClient = {
        //For the tutorial we use a hard coded api key and application group identifier
        var config = ChatClientConfig(apiKey: .init("564bpb2p4496"))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = "group.com.chatapp.dev.Chatapp"

        // The resulting config is passed into a new `ChatClient` instance.
        let client = ChatClient(config: config)
        return client
    }()
    
    @State var streamChat: StreamChat?
        
    private init() {
        
        var colors = ColorPalette()
        colors.tintColor = .white
        colors.text = UIColor.white
        colors.background = UIColor.customBlack
        colors.background1 = UIColor.customBlack
        colors.background8 = UIColor.customBlack
        colors.messageCurrentUserBackground = [UIColor(hex: 0xD2F36E, alpha: 1.0)]
        colors.messageOtherUserBackground = [UIColor.white]
        colors.quotedMessageBackgroundCurrentUser = UIColor(hex: 0xD2F36E, alpha: 1.0)
        colors.quotedMessageBackgroundOtherUser = UIColor.white
        colors.messageCurrentUserTextColor = .black
        colors.messageOtherUserTextColor = .black
        
        var fonts = Fonts()
        fonts.title = Font.custom("FiraCode-Medium", size: 28)
        fonts.title3 = Font.custom("FiraCode-Medium", size: 20)
        fonts.body = Font.custom("FiraCode-Medium", size: 17)
        fonts.headline = Font.custom("FiraCode-Medium", size: 17)
        fonts.subheadline = Font.custom("FiraCode-Medium", size: 15)
        fonts.footnote = Font.custom("FiraCode-Medium", size: 13)
        fonts.caption1 = Font.custom("FiraCode-Medium", size: 12)

        fonts.footnoteBold = Font.custom("FiraCode-Bold", size: 13)
        fonts.subheadlineBold = Font.custom("FiraCode-Bold", size: 15)
        fonts.bodyBold = Font.custom("FiraCode-Bold", size: 17)
        fonts.headlineBold = Font.custom("FiraCode-Bold", size: 17)

        let appearance = Appearance(colors: colors, fonts: fonts)
        streamChat = StreamChat(chatClient: chatClient, appearance: appearance)
        connectUser()
    }
    
    private func connectUser() {
        
        guard let user = AuthManager.shared.getUser() else { return }
                    
        chatClient.connectUser(
            userInfo: .init(
                id: user.userID!,
                name: user.profile?.name,
                imageURL: URL(string: user.profile?.imageURL(withDimension: 100)?.absoluteString ?? "")
            ),
            token: .development(userId: user.userID!)
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
}
