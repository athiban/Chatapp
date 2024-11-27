//
//  CustomMessageComposer.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import SwiftUI

struct BackgroundViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(Color.customBlack)
    }
}
