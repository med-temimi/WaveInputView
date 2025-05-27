//
//  BorderedButtonStyle.swift
//  WaveInputView
//
//  Created by Macbook Pro  M'ed on 27/05/25.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    var tint: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(tint.opacity(configuration.isPressed ? 0.6 : 0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
