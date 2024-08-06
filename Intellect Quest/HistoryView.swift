//
//  HistoryView.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct HistoryView: View {
    @State private var history: [QuizResult] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(history) { result in
                        HStack {
                            Text("Score: \(result.score)")
                            Spacer()
                            Text("\(result.date, formatter: dateFormatter)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Quiz History")
                .onAppear {
                    history = QuizHistoryManager.shared.getHistory()
                }
                
                Button(action: {
                    deleteAllHistory()
                }) {
                    Text("Delete All History")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(.capsule)
                        .shadow(radius: 2)
                }
                .padding()
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    private func deleteItems(at offsets: IndexSet) {
        offsets.forEach { index in
            let result = history[index]
            QuizHistoryManager.shared.deleteResult(result)
        }
        history.remove(atOffsets: offsets)
    }
    
    private func deleteAllHistory() {
        QuizHistoryManager.shared.clearHistory()
        history = []
    }
}

#Preview {
    HistoryView()
}
