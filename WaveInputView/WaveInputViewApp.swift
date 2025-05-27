//
//  WaveInputViewApp.swift
//  WaveInputView
//
//  Created by Macbook Pro  M'ed on 27/05/25.
//

import SwiftUI

@main
struct WaveInputViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
