//
//  SearchView.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 28/11/24.
//

import SwiftUI
import StreamChatSwiftUI
import StreamChat

struct SearchUsersView: View {

    @StateObject var viewModel: NewChatViewModel

    var body: some View {
        HStack {
            TextField("Type a name", text: $viewModel.searchText, prompt: Text("Search users").foregroundStyle(Color.white.opacity(0.5)))
                .textFieldStyle(CustomSearchFieldStyle())
                .foregroundStyle(Color.white)
        }
    }
}
