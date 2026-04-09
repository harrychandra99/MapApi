//
//  ContentView.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI

struct WeatherViewController: View {
    
    @State var searchText = ""
    
    @StateObject private var state = WeatherState()
    
    private var presenter: WeatherPresenter
    
    init() {
        let service = WeatherService()
        let presenter = WeatherPresenter(service: service)
                
        self.presenter = presenter
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(colors: [.blue.opacity(0.1), .white], startPoint: .top, endPoint: .bottom)
                VStack{
                    if let weather = state.weather {
                        WeatherInfoView(weather: weather)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    else if let error = state.errorMessage {
                        // Tampilan kalau API error atau internet mati
                        VStack(spacing: 15) {
                            Image(systemName: "wifi.exclamationmark")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                            Text(error)
                                .multilineTextAlignment(.center)
                            Button("Try Again") {
                                presenter.fetchData(lat: -6.2, lon: 106.8)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    } else if !state.isLoading {
                        ContentUnavailableView("Search City",
                                               systemImage: "magnifyingglass",
                                               description: Text("Start by searching or using your location"))
                    }
                    
                }
                .blur(radius: state.isLoading ? 3 : 0)
                .animation(.easeInOut, value: state.isLoading)
                
                if state.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Fetching Data...")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .padding(25)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    
                }
            }
//            .navigationTitle("Weather App")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CustomToolBarView(onSearch: {query in
                        self.searchText = query}, onLocation: {presenter.fetchData(lat: -6.2088, lon: 106.8456)
                        }
                    )
                   
                }
            }
            .onAppear {
                // Auto-load data pas pertama kali aplikasi dibuka
                presenter.view = state
                
                if state.weather == nil {
                    presenter.fetchData(lat: -6.2088, lon: 106.8456)
                }
            }
        }
    }
}
