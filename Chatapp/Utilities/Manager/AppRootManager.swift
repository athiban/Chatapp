//
//  AppRootManager.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import Foundation

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: eAppRoots = .splash
    
    enum eAppRoots {
        case splash
        case authentication
        case home
    }
}
