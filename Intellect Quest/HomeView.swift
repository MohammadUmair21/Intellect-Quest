//
//  HomeView.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
               Image("Q4")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 10)
                
                Button( action: {
                    navigateToQuizView()
                }) {
                        Text("START")
                            .font(.title)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.primary)
                            .bold()
                            .shadow(radius: 5)
                    }
                
                Spacer()
                
                }
            .applyGradientBackground()
            .navigationBarHidden(true)
            }
    }
}
func navigateToQuizView() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: QuizView())
            window.makeKeyAndVisible()
        }
    }

#Preview {
    HomeView()
}
