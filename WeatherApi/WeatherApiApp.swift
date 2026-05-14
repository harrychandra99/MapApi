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
    let container: ModelContainer
    init() {
        do{
            container = try ModelContainer(for:WeatherDayEntity.self, WeatherItemEntity.self)
            
            SwiftDataManager.shared.modelContext = ModelContext(container)
        } catch {
            fatalError("Failed to initialize Modelcontainer")
        }
    }
    var body: some Scene {
        WindowGroup {
            WeatherAppLoader()
        }
        .modelContainer(container)
    }
}

struct WeatherAppLoader: View {

    var body: some View {
        WeatherViewController().ignoresSafeArea()
    }
}

//struct UIKitViewBridge: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> SavedDataViewController {
//        return SavedDataViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: SavedDataViewController, context: Context) {}
//}
