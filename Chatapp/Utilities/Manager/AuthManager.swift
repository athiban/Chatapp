//
//  AuthManager.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import Foundation
import SwiftKeychainWrapper
import GoogleSignIn

struct Credentials {
    var accessToken: String?
    var refreshToken: String?
}

enum KeychainKey: String {
    case accessToken
    case refreshToken
    case user
}

class AuthManager: ObservableObject {
    
    static let shared: AuthManager = AuthManager()
    private let keychain: KeychainWrapper = KeychainWrapper.standard
    
    @Published var loggedIn: Bool = false
    
    private init() {
        loggedIn = hasAccessToken()
    }
    
    func getCredentials() -> Credentials {
        return Credentials(
            accessToken: keychain.string(forKey: KeychainKey.accessToken.rawValue),
            refreshToken: keychain.string(forKey: KeychainKey.refreshToken.rawValue)
        )
    }
    
    func setCredentials(user: GIDGoogleUser) {
        keychain.set(user.idToken!.tokenString, forKey: KeychainKey.accessToken.rawValue)
        keychain.set(user.refreshToken.tokenString, forKey: KeychainKey.refreshToken.rawValue)
        keychain.set(user, forKey: KeychainKey.user.rawValue)

        loggedIn = true
    }
    
    func hasAccessToken() -> Bool {
        return getCredentials().accessToken != nil
    }
    
    func getAccessToken() -> String? {
        return getCredentials().accessToken
    }

    func getRefreshToken() -> String? {
        return getCredentials().refreshToken
    }
    
    func getUser() -> GIDGoogleUser? {
        return keychain.object(forKey: KeychainKey.user.rawValue) as? GIDGoogleUser
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.accessToken.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.refreshToken.rawValue)
        
        loggedIn = false
    }
    
}
