//
//  WaveUnderline.swift
//  WaveInputView
//
//  Created by Macbook Pro  M'ed on 27/05/25.
//

import SwiftUI

struct WaveUnderline: View {
    @ObservedObject var viewModel: WaveInputViewModel
    var color: Color = Color.accentColor
    var staticLineColor: Color = .gray

    @State private var phase: CGFloat = 0.0
    private let animationSpeed: CGFloat = 0.5

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height: CGFloat = 40
            let waveLength = width / 20
            let isActive = !viewModel.levels.allSatisfy { $0 <= 0.1 }

            if isActive {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: height / 2))
                    let levelCount = viewModel.levels.count
                    let step = max(1, levelCount / Int(width))

                    for x in stride(from: 0, to: width, by: 1) {
                        let index = min(Int(CGFloat(x) / width * CGFloat(levelCount)), levelCount - 1)
                        let amplitude = viewModel.levels[index]

                        let relativeX = CGFloat(x) / waveLength
                        let y = (height / 2) * sin(relativeX * 2 * .pi + phase) * amplitude
                        path.addLine(to: CGPoint(x: CGFloat(x), y: height / 2 + y))
                    }
                }
                .stroke(color, lineWidth: 2)
            } else {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: height / 2))
                    path.addLine(to: CGPoint(x: width, y: height / 2))
                }
                .stroke(staticLineColor, lineWidth: 1)
            }
        }
        .frame(height: 6)
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                phase = 2 * .pi
            }
        }
    }
}
