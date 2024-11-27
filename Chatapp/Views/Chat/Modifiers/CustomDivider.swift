//
//  CustomDivider.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import SwiftUI

struct CustomDivider: View {
    let color: Color = .gray.opacity(0.5)
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .padding(.leading, 8).padding(.trailing, 8)
    }
}
