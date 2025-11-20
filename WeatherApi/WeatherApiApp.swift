//
//  WeatherApiApp.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI

@main
struct WeatherApiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
