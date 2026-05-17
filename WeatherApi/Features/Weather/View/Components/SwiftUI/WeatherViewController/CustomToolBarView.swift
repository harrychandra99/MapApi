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
    private var onHistory: () -> Void
    
    //Image
    private var locationIcon = "location.fill"
    private var searchIcon = "magnifyingglass"
    private var historyIcon = "clock.arrow.circlepath"
    
    
    private var placeHolder: String = "Search..."
    private var textHolder = "Current Location: ...."
    
    init(
        onSearch: @escaping (String) -> Void,
        onLocation: @escaping () -> Void,
        onHistory: @escaping () -> Void
    ) {
        self.onSearch = onSearch
        self.onLocation = onLocation
        self.onHistory = onHistory
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
                .onChange(of: text) {
                    onSearch(text)
                }
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
            
            Button(action: {
                onHistory()
            }) {
                Image(systemName: historyIcon)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .animation(.snappy, value: text)
    }
}
