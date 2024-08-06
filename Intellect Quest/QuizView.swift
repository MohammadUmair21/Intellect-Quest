//
//  QuizView.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct QuizView: View {
    
    @State private var showAlert = false
    @State private var showTimeUpAlert = false
    @State private var timer : Timer?
    @State private var timeRemaining = 60
    @State private var currentQuestionIndex = 0
    @State private var questions : [Question] = []
    @State private var score = 0
    @State private var selectedOption: String? = nil
    
    
    
    struct Question: Codable, Hashable {
        let question : String
        let type : String
        let options : [String]
        let correct_option_index : Int
    }
    
    struct QuizData : Codable {
        let time_per_question : Int
        let questions : [Question]
    }
    
    var body: some View {
        VStack{
            Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Exit button tapped")
                                showAlert = true
                                stopTimer()
                            }) {
                                Image("exit")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            .padding()
                        }
            
            Spacer()
            
            if questions.isEmpty {
                Text("Loading...")
                    .font(.title)
                    .applyGradientBackground()
                
            } else {
                Text("Time Remaining : \(timeRemaining) seconds")
                    .font(.headline)
                    .padding()
                
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                                    .font(.subheadline)
                                    .padding()
                
                Text(questions[currentQuestionIndex].question)
                    .font(.title)
                    .frame(width: 370,height: 100)
                    .background(.thinMaterial.opacity(0.5))
                    .cornerRadius(10)
                    .padding()
                
                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                    Button(action: {
                        answerQuestion(option: option)
                    }) {
                        Text(option)
                            .padding()
                            .frame(width: 370)
                            .background(self.getBackgroundColor(for: option))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 400)
                            .padding(.vertical,2)
                    }
                }
                Spacer()
                
                Spacer()
            }
        }
            .applyGradientBackground()
            .navigationBarBackButtonHidden()
            .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Quit Quiz"),
                            message: Text("Are you sure you want to quit to the main menu?"),
                            primaryButton: .cancel(Text("Continue")) {
                                startTimer()
                            },
                            secondaryButton: .destructive(Text("Quit"), action: {
                                if let window = UIApplication.shared.windows.first {
                                    window.rootViewController = UIHostingController(rootView: ContentView())
                                    window.makeKeyAndVisible()
                                }
                            })
                        )
                    }
            .alert(isPresented: $showTimeUpAlert) {
                Alert(
                title: Text("Time's Up!"),
                message: Text("Your time has ended. Let's see how you did."),
                dismissButton: .default(Text("Ok")) {
                    navigateToResultView()
                }
            )
        }
            .onAppear(perform: loadQuizData)
    }
    
    func loadQuizData() {
        if let url = Bundle.main.url(forResource: "quiz", withExtension: "json") {
            print("JSON URL: \(url)")
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                do {
                    let quizData = try decoder.decode(QuizData.self, from: data)
                    self.questions = Array(quizData.questions.shuffled().prefix(10))
                    self.timeRemaining = quizData.time_per_question
                    startTimer()
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Failed to load data from JSON file.")
            }
        } else {
            print("Failed to locate JSON file.")
        }
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                showTimeUpAlert = true
            }
        }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func answerQuestion(option : String) {
        selectedOption = option
        
        let correctAnswer = questions[currentQuestionIndex].options[questions[currentQuestionIndex].correct_option_index]
        if option == correctAnswer {
            score += 10
        } else {
            score += 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                timeRemaining = 60
                startTimer()
            } else {
                navigateToResultView()
            }
        }
    }
    
    func getBackgroundColor(for option: String) -> Color {
            guard let selectedOption = selectedOption else {
                return Color.secondary
            }
            
            if selectedOption == option {
                return option == questions[currentQuestionIndex].options[questions[currentQuestionIndex].correct_option_index] ? Color.green : Color.red
            }
            
            return Color.secondary
        }
    
    func navigateToResultView() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ResultView(score: score))
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    QuizView()
}
