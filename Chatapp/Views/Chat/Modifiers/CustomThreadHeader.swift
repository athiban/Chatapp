//
//  CustomThreadHeader.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

public struct CustomThreadHeader: ToolbarContent {
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) private var colors
    public var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Threads Reply")
                    .font(fonts.bodyBold)
                    .foregroundStyle(Color.white)
                Text("With messages")
                    .font(fonts.footnote)
                    .foregroundColor(Color(colors.textLowEmphasis))
            }
        }
    }
}
/// The default message thread header modifier.
public struct CustomThreadHeaderHeaderModifier: MessageThreadHeaderViewModifier {
    public func body(content: Content) -> some View {
        content.toolbar {
            CustomThreadHeader()
        }
        .toolbarBackground(Color.customBlack, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarRole(.editor)
    }
}
