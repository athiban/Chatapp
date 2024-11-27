//
//  CustomTextField.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @State var text: String = ""
    @State var placeHolder: String = ""
    @State var title: String = ""
    @State var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.custom("FiraCode-Medium", size: 20))
                .foregroundStyle(.white)
            if isSecure {
                SecureField(placeHolder, text: $text, prompt: Text(placeHolder).foregroundStyle(Color.white.opacity(0.5)))
                    .textFieldStyle(CustomTextFieldStyle())
                    .frame(height: 40)
                    .font(.custom("FiraCode-Medium", size: 15))
            }
            else {
                TextField(placeHolder, text: $text, prompt: Text(placeHolder).foregroundStyle(Color.white.opacity(0.5)))
                    .textFieldStyle(CustomTextFieldStyle())
                    .frame(height: 40)
                    .font(.custom("FiraCode-Medium", size: 15))
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(hex: 0x454545))
            .cornerRadius(20)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color(hex: 0x757575), lineWidth: 1))
    }
}

struct CustomSearchFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(hex: 0x454545))
            .cornerRadius(20)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color(hex: 0x757575), lineWidth: 1))
    }
}
