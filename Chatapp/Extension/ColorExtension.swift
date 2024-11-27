//
//  ColorExtension.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import UIKit
import SwiftUICore

extension Color {
    
    static var customBlack = Color(hex: 0x272727, alpha: 1.0)
    static var customNeon = Color(hex: 0xD7FE62, alpha: 1.0)
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension UIColor {
    
    static var customBlack = UIColor(hex: 0x272727, alpha: 1.0)
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
