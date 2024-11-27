//
//  NewChatView.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import StreamChat
import StreamChatSwiftUI
import SwiftUI

struct NewChatView: View, KeyboardReadable {

    @Injected(\.fonts) var fonts
    @Injected(\.colors) var colors

    @StateObject var viewModel = NewChatViewModel()

    @Binding var isNewChatShown: Bool

    @State private var keyboardShown = false

    let columns = [GridItem(.adaptive(minimum: 120), spacing: 2)]

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.state != .channel {
                SearchUsersView(viewModel: viewModel)
                    .frame(height: 40)
                    .padding()
            }
            
            if viewModel.state == .loading {
                VerticallyCenteredView {
                    ProgressView()
                }
            } else if viewModel.state == .loaded {
                List(viewModel.chatUsers) { user in
                    Button {
                        withAnimation {
                            viewModel.userTapped(user)
                        }
                    } label: {
                        ChatUserView(
                            user: user,
                            onlineText: viewModel.onlineInfo(for: user)
                        )
                        .onAppear {
                            viewModel.onChatUserAppear(user)
                        }
                    }
                    .listRowBackground(Color.customBlack)
                }
                .listStyle(.plain)
            } else if viewModel.state == .noUsers {
                VerticallyCenteredView {
                    Text("No user matches these keywords")
                        .font(.title2)
                        .foregroundColor(Color(colors.textLowEmphasis))
                }
            } else if viewModel.state == .error {
                VerticallyCenteredView {
                    Text("Error loading the users")
                        .font(.title2)
                        .foregroundColor(Color(colors.textLowEmphasis))
                }
            } else if viewModel.state == .channel, let controller = viewModel.channelController {
                Divider()
                ChatChannelView(
                    viewFactory: CustomFactory.shared,
                    channelController: controller
                )
                .toolbarBackground(Color.customBlack, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            } else {
                Spacer()
            }
        }
        .navigationTitle("").foregroundStyle(.white)
        .background(Color.customBlack)
        .onReceive(keyboardWillChangePublisher) { visible in
            keyboardShown = visible
        }
        .modifier(HideKeyboardOnTapGesture(shouldAdd: keyboardShown))
    }
}

struct VerticallyCenteredView<Content: View>: View {

    var content: () -> Content

    var body: some View {
        VStack {
            Spacer()
            content()
            Spacer()
        }
    }
}
