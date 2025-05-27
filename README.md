# 🎙️ WaveInputView

A lightweight and customizable SwiftUI component for visualizing live microphone input as animated waves — perfect for voice interactions or playful UI feedback.

## ✨ Features

- Live audio input visualization
- Smooth animations & responsive design
- MVVM architecture for easy integration
- Reusable in any SwiftUI project

## 🚀 Usage

```swift
@StateObject private var viewModel = WaveInputViewModel()
@State private var selectedStyle: WaveStyle = .bar

WaveInputView(viewModel: viewModel, waveStyle: selectedStyle)
```

⏯️ Use startMonitoring() and stopMonitoring() to control audio capture:

```swift

 @StateObject private var viewModel = WaveInputViewModel()

 WaveInputView(viewModel: viewModel, waveStyle: selectedStyle)
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)

 Button("Start Monitoring") { viewModel.startMonitoring() }

 Button("Stop Monitoring") { viewModel.stopMonitoring() }

```


📋 Info.plist

⚠️ Add this to your Info.plist:
```swift
<key>NSMicrophoneUsageDescription</key>
<string>We use your mic to visualize sound input as animated waves.</string>
```

📦 Requirements

iOS 15+
SwiftUI
Swift 5.7+

## 🎬 Preview

![WaveInputView Demo](Assets/preview.gif)


MIT © TEMIMI-MOHAMED

