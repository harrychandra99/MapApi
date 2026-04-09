//
//  CustomBarView.swift
//  WeatherApi
//
//  Created by Kalvin on 21/12/25.
//

import SwiftUI

struct CustomToolBarView: View {
    
    @State private var text: String = ""
    
    private var onSearch: (String) -> Void
    private var onLocation: () -> Void
    
    //Image
    private var locationIcon = "location.fill"
    private var searchIcon = "magnifyingglass"
    
    
    private var placeHolder: String = "Search..."
    private var textHolder = "Current Location: ...."
    
    init(
        onSearch: @escaping (String) -> Void,
        onLocation: @escaping () -> Void
    ) {
        self.onSearch = onSearch
        self.onLocation = onLocation
    }
    
    
    var body: some View {
        HStack {
            Button(action: {
                onLocation()
            }) {
                Image(systemName: locationIcon)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            TextField(placeHolder, text: $text)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .onSubmit {
                    onSearch(text)
                }
            
            Button(action: {
                onSearch(text)
            }) {
                Image(systemName: searchIcon)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(10)
        .background(.ultraThinMaterial) // Efek glassmorphism 2025
        .cornerRadius(12)
        .animation(.snappy, value: text)
    }
}
