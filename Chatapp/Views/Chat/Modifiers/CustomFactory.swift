//
//  CustomFactory.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import StreamChatSwiftUI
import SwiftUI
import StreamChat

struct NoSearchView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

class CustomFactory: ViewFactory {
    @Injected(\.chatClient) public var chatClient
    private init() {}
    public static let shared = CustomFactory()
    
    func makeChannelListTopView(
        searchText: Binding<String>
    ) -> some View {
        NoSearchView()
    }
    
    func makeLoadingView() -> some View {
        VStack {
            ProgressView()
                .tint(Color(hex: 0x7B7B7B, alpha: 1.0))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.customBlack)
    }
    
    func makeNoChannelsView() -> some View {
        VStack {
            Spacer()
            Image(systemName: "bubble.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/3.5)
                .foregroundStyle(.white)
            Text("No channels available")
                .foregroundStyle(Color(hex: 0x7B7B7B, alpha: 1.0))
                .font(.custom("FiraCode-Medium", size: 15))
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.customBlack)
    }
    
    func makeChannelListBackground(colors: ColorPalette) -> some View {
        Color.customBlack
            .edgesIgnoringSafeArea(.bottom)
    }
    
    func makeChannelListHeaderViewModifier(title: String) -> some ChannelListHeaderViewModifier {
        CustomChannelModifier(title: title)
    }
    
    func makeChannelHeaderViewModifier(for channel: ChatChannel) -> some ChatChannelHeaderViewModifier {
        CustomChatChannelModifier(channel: channel)
    }
        
    func makeComposerViewModifier() -> some ViewModifier {
        BackgroundViewModifier()
    }
    
    func makeMessageThreadHeaderViewModifier() -> some MessageThreadHeaderViewModifier {
        CustomThreadHeaderHeaderModifier()
    }
    
    func makeChannelListDividerItem() -> some View {
        CustomDivider()
    }
}
