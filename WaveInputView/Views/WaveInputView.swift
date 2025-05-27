//
//  WaveInputView.swift
//  WaveInputView
//
//  Created by Macbook Pro  M'ed on 27/05/25.
//

import SwiftUI

struct WaveInputView: View {
    @ObservedObject var viewModel: WaveInputViewModel
    var waveStyle: WaveStyle = .bar  // default style

    var body: some View {
        HStack(spacing: 4) {
            ForEach(viewModel.levels, id: \.self) { level in
                waveShape(for: level)
                    .foregroundColor(Color.accentColor.opacity(0.7))
                    .frame(width: 6, height: max(1, level * 100))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.05), value: viewModel.levels)
    }

    @ViewBuilder
    private func waveShape(for level: CGFloat) -> some View {
        switch waveStyle {
        case .bar:
            Rectangle()
        case .capsule:
            Capsule()
        case .circle:
            Circle()
                .frame(width: 6, height: max(1, level * 100))
        case .custom:
                // TODO: - You can create and set a custom wave style here
            RoundedRectangle(cornerRadius: 3)
        }
    }
}

