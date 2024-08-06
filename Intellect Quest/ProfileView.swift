//
//  ProfileView.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            
            Text("Login")
                .font(.largeTitle)
                .padding()
                .bold()
            
                    Button(action: {
                        // Google login
                    }) {
                        Text("Google")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .frame(width: 350)
                            .shadow(radius: 20)
                            .padding(.horizontal)
                    }
                    .padding()
            
                    Button(action: {
                        // Facebook login
                    }) {
                        Text("Facebook")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .frame(width: 350)
                            .shadow(radius: 20)
                            .padding(.horizontal)
                    }
                    .padding()
            
            Button(action: {
                // Facebook login
            }) {
                Text("Login as guest")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .frame(width: 350)
                    .shadow(radius: 20)
                    .padding(.horizontal)
            }
            .padding()
                }
        .frame(width: 1000, height: 1000)
        .applyGradientBackground()
    }
}

#Preview {
    ProfileView()
}
