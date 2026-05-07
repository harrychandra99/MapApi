//
//  WeatherApiApp.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI
import SwiftData

@main
struct WeatherApiApp: App {
    @Environment(\.modelContext) private var modelContext

    var body: some Scene {
        WindowGroup {
            WeatherViewController(modelContext: modelContext)
//         UIKitViewBridge()
//                .ignoresSafeArea()
        }
        .modelContainer(for: [WeatherDayEntity.self, WeatherItemEntity.self])
    }
}

//struct UIKitViewBridge: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> SavedDataViewController {
//        return SavedDataViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: SavedDataViewController, context: Context) {}
//}
