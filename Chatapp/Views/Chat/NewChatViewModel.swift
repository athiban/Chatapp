//
//  NewChatViewModel.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//

import StreamChat
import StreamChatSwiftUI
import SwiftUI

class NewChatViewModel: ObservableObject, ChatUserSearchControllerDelegate {

    @Injected(\.chatClient) var chatClient

    @Published var searchText: String = "" {
        didSet {
            searchUsers(with: searchText)
        }
    }

    @Published var messageText: String = ""
    @Published var chatUsers = [ChatUser]()
    @Published var state: NewChatState = .initial
    @Published var selectedUser: ChatUser! {
        didSet {
            do {
                try makeChannelController()
            } catch {
                state = .error
                updatingSelectedUsers = false
            }
        }
    }

    private var loadingNextUsers: Bool = false
    private var updatingSelectedUsers: Bool = false

    var channelController: ChatChannelController?

    private lazy var searchController: ChatUserSearchController = chatClient.userSearchController()
    private let lastSeenDateFormatter = DateUtils.timeAgo

    init() {
        chatUsers = searchController.userArray.filter({$0.id != AuthManager.shared.getUser()!.userID!})
        searchController.delegate = self
        // Empty initial search to get all users
        searchUsers(with: nil)
    }

    func userTapped(_ user: ChatUser) {
        selectedUser = user
    }

    func onlineInfo(for user: ChatUser) -> String {
        if user.isOnline {
            return "Online"
        } else if let lastActiveAt = user.lastActiveAt,
                  let timeAgo = lastSeenDateFormatter(lastActiveAt) {
            return timeAgo
        } else {
            return "Offline"
        }
    }

    func onChatUserAppear(_ user: ChatUser) {
        guard let index = chatUsers.firstIndex(where: { element in
            user.id == element.id
        }) else {
            return
        }

        if index < chatUsers.count - 10 {
            return
        }

        if !loadingNextUsers {
            loadingNextUsers = true
            searchController.loadNextUsers(limit: 50) { [weak self] _ in
                guard let self = self else { return }
                self.chatUsers = self.searchController.userArray.filter({$0.id != AuthManager.shared.getUser()!.userID!})
                self.loadingNextUsers = false
            }
        }
    }

    // MARK: - ChatUserSearchControllerDelegate

    func controller(
        _ controller: ChatUserSearchController,
        didChangeUsers changes: [ListChange<ChatUser>]
    ) {
        chatUsers = controller.userArray.filter({$0.id != AuthManager.shared.getUser()!.userID!})
    }

    // MARK: - private

    private func searchUsers(with term: String?) {
        state = .loading
        searchController.search(term: term) { [weak self] error in
            if error != nil {
                self?.state = .error
            } else {
                self?.state = .loaded
            }
        }
    }

    private func makeChannelController() throws {

        channelController = try chatClient.channelController(
            createDirectMessageChannelWith: Set([selectedUser.id]),
            name: nil,
            imageURL: nil,
            extraData: [:]
        )
                
        channelController?.synchronize { [weak self] error in
            if error != nil {
                self?.state = .error
            } else {
                withAnimation {
                    self?.state = .channel
                }
            }
        }
    }
}

enum NewChatState {
    case initial
    case loading
    case noUsers
    case error
    case loaded
    case channel
}
