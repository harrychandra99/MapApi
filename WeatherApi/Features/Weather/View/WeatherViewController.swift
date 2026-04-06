//
//  ContentView.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI

struct WeatherViewController: View {
    
    @State private var searchText = ""
//    @State private var items = ["Jakarta", "Banana", "Cherry", "Date", "Elderberry"]
//    
//    var searchResults: [String] {
//        if searchText.isEmpty {
//            return items
//        } else {
//            return items.filter { $0.contains(searchText) }
//        }
//    }
//    
    var body: some View {
        NavigationStack {
            Text("Konten Utama Di Sini") // Placeholder agar layar tidak kosong
            
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CustomToolBarView(onSearch: {query in
                        self.searchText = query}, onLocation: {print("Fetching Current Location...")
                        }
                    )
                        .frame(height: 44) // Or remove this line if CustomBarView sizes itself sensibly
                }
            }
        }
    }

    
}
