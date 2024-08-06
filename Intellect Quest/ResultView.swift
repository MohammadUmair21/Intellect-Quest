//
//  ResultView.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct ResultView: View {
    let score: Int

    var body: some View {
            VStack {
                
                Text("Quiz Completed!")
                    .font(.largeTitle)
                
                Text("__________________________________")
                
                Text("Your Score: \(score)")
                    .font(.title)
                    .padding()
                
                
                Image(getImageName(for: score))
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: 500, height: 250)
                    .shadow(radius: 50)
                    .padding()
                
                Button(action: {
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: ContentView())
                        window.makeKeyAndVisible()
                    }
                }) {
                    Text("Back to Home")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
            }
            .frame(width: 1000, height: 1000)
            .onAppear {
                        saveResult()
                    }
            .applyGradientBackground()
        }
        
        func getImageName(for score: Int) -> String {
            switch score {
            case 0...60:
                return "average_score"
            case 61...79:
                return "good_score"
            case 80...99:
                return "great_score"
            case 100:
                return "perfect_score"
            default:
                return "average_score"
            }
        }
    func saveResult() {
            let result = QuizResult(score: score, date: Date())
            QuizHistoryManager.shared.saveResult(result)
        }
    }

#Preview {
    ResultView(score: 100)
}
