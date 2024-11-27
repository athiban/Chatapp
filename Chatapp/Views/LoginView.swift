//
//  LoginView.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 26/11/24.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        ZStack {
            ScrollView(content: {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.customNeon, lineWidth: 1)
                        )
                    VStack (spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Login")
                                .font(.custom("FiraCode-Medium", size: 30))
                                .foregroundStyle(.white)
                            Text("Login in to continue using the app")
                                .multilineTextAlignment(.leading)
                                .font(.custom("FiraCode-Medium", size: 15))
                                .foregroundStyle(.gray)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        CustomTextField(placeHolder: "Enter your email", title: "Email")
                        VStack(alignment: .trailing, spacing: 8) {
                            CustomTextField(placeHolder: "Enter your password", title: "Password")
                            Button("Forget Password?", action: {})
                            .foregroundStyle(Color(hex: 0x7B7B7B, alpha: 1.0))
                            .font(.custom("FiraCode-Medium", size: 15))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        Button {
                            
                        } label: {
                            Text("Login")
                                .font(.custom("FiraCode-Medium", size: 15))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundStyle(Color.black)
                        }
                        .buttonStyle(.plain)
                        .background(Color(hex: 0xD2F36E, alpha: 1.0))
                        .cornerRadius(20)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    VStack (spacing: 0) {
                        Text("Or Login with")
                            .foregroundStyle(Color.white)
                            .font(.custom("FiraCode-Medium", size: 13))
                        Button {
                            handleSignInButton()
                        } label: {
                            Image("gLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 20, alignment: .center)
                                .padding(10)
                        }
                        .buttonStyle(.plain)
                        .background(Color.white)
                        .cornerRadius(20)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .padding(.top, -4)
                    }
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(Color.white)
                            .font(.custom("FiraCode-Medium", size: 13))
                        Button("Register", action: {
                            
                        })
                        .foregroundStyle(Color(hex: 0xD2F36E, alpha: 1.0))
                        .font(.custom("FiraCode-Medium", size: 15))
                    }
                }
                .background(Color.customBlack)
                .frame(minWidth: 0, maxWidth: .infinity)
            })
            .background(Color.customBlack)
        }
    }
    
    func handleSignInButton() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController) { signInResult, error in
                guard let result = signInResult else {
                    return
                }
                AuthManager.shared.setCredentials(user: result.user)
                let _ = StreamManager.shared
                appRootManager.currentRoot = .home
            }
    }
}

#Preview {
    LoginView()
}
