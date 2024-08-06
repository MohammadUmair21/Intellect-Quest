//
//  QuizHistoryManager.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import Foundation

class QuizHistoryManager {
    static let shared = QuizHistoryManager()
    
    private let userDefaultsKey = "quizHistory"
    
    func saveResult(_ result: QuizResult) {
        var history = getHistory()
        history.append(result)
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func getHistory() -> [QuizResult] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let history = try? JSONDecoder().decode([QuizResult].self, from: data) {
            return history
        }
        return []
    }
    
    func deleteResult(_ result: QuizResult) {
        var history = getHistory()
        if let index = history.firstIndex(where: { $0.id == result.id }) {
            history.remove(at: index)
            if let encoded = try? JSONEncoder().encode(history) {
                UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
            }
        }
    }
    
    func clearHistory() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}

struct QuizResult: Codable, Identifiable {
    var id = UUID()
    let score: Int
    let date: Date
}
