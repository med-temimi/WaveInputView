//
//  WaveInputViewModel.swift
//  WaveInputView
//
//  Created by Macbook Pro  M'ed on 27/05/25.
//

import SwiftUI
import AVFoundation
import Combine

class WaveInputViewModel: ObservableObject {

    @Published var levels: [CGFloat] = Array(repeating: 0.1, count: 100)

    private var timer: Timer?
    private var audioRecorder: AVAudioRecorder?

    init() {
        setupRecorder()
        startMonitoring()
    }

    deinit {
        timer?.invalidate()
        audioRecorder?.stop()
    }

    private func setupRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
        try? audioSession.setActive(true)

        let url = URL(fileURLWithPath: "/dev/null")
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]

        audioRecorder = try? AVAudioRecorder(url: url, settings: settings)
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
    }

    func startMonitoring() {
        setupRecorder()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self, let recorder = self.audioRecorder else { return }
            recorder.updateMeters()
            let avgPower = recorder.averagePower(forChannel: 0)
            let level = max(0.05, CGFloat((avgPower + 160) / 160))

            var newLevels = self.levels
            newLevels.removeFirst()
            newLevels.append(level)

            DispatchQueue.main.async {
                self.levels = newLevels
            }
        }
    }

    func stopMonitoring() {
        timer?.invalidate()
        timer = nil

        audioRecorder?.stop()
        audioRecorder = nil

        DispatchQueue.main.async {
            self.levels = Array(repeating: 0.1, count: self.levels.count)
        }
    }
    
}
