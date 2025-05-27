    //
    //  ContentView.swift
    //  WaveInputView
    //
    //  Created by Macbook Pro  M'ed on 27/05/25.
    //

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WaveInputViewModel()
    @State private var selectedStyle: WaveStyle = .bar

    var body: some View {
        ZStack {
            VStack(spacing: 0) {

                    // MARK: - Header
                VStack {
                    Text("🎙️ Tap Start, Speak Up, and Feel the Waves Dance Live!")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(Color("TitleColor"))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.accentColor.opacity(0.1))
                                .shadow(color: Color.accentColor.opacity(0.3), radius: 5, x: 0, y: 3)
                        )
                }
                .padding(.top, 40)
                .padding(.horizontal)

                    // MARK: - Wave Display Area
                VStack(spacing: 24) {
                    Spacer()

                    VStack(spacing: 32) {
                        WaveInputView(viewModel: viewModel, waveStyle: selectedStyle)
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)

                        WaveUnderline(viewModel: viewModel)
                            .frame(height: 6)
                            .padding(.horizontal, 32)
                            .padding(.top, 60)
                    }

                    Spacer()

                        // MARK: - Controls
                    VStack(spacing: 24) {
                        Picker("Wave Style", selection: $selectedStyle) {
                            Text("Bar").tag(WaveStyle.bar)
                            Text("Capsule").tag(WaveStyle.capsule)
                            Text("Circle").tag(WaveStyle.circle)
                            Text("Custom").tag(WaveStyle.custom)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        .padding(.vertical, 30)

                        HStack(spacing: 20) {
                            Button("Start Monitoring") {
                                viewModel.startMonitoring()
                            }
                            .buttonStyle(BorderedButtonStyle(tint: .green))
                            .frame(maxWidth: .infinity)

                            Button("Stop Monitoring") {
                                viewModel.stopMonitoring()
                            }
                            .buttonStyle(BorderedButtonStyle(tint: .red))
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal)
                        .frame(height: 44)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
