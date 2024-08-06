//
//  GradientBackground.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(2), Color.red.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func applyGradientBackground() -> some View {
        self.modifier(GradientBackground())
    }
}
