//
//  ContentView.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI

struct WeatherViewController: View {
    
    @State var searchText = ""
    
    @StateObject var presenter = WeatherPresenter(service: WeatherService())
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(colors: [.blue.opacity(0.1), .white], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    if let weather = presenter.weather {
                        WeatherInfoView(weather: weather)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    else if let error = presenter.errorMessage {
                        // Tampilan kalau API error atau internet mati
                        VStack(spacing: 15) {
                            Image(systemName: "wifi.exclamationmark")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                            Text(error)
                                .multilineTextAlignment(.center)
                            Button("Try Again") {
                                // Panggil ulang data Jakarta (Contoh)
                                presenter.fetchData(lat: -6.2, lon: 106.8)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    } else if !presenter.isLoading {
                        ContentUnavailableView("Search City",
                                               systemImage: "magnifyingglass",
                                               description: Text("Start by searching or using your location"))
                    }
                    
                }
                .blur(radius: presenter.isLoading ? 3 : 0) // Efek blur pas lagi loading
                .animation(.easeInOut, value: presenter.isLoading)
                
                if presenter.isLoading {
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
            .navigationTitle("Weather App")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CustomToolBarView(onSearch: {query in
                        self.searchText = query}, onLocation: {presenter.fetchData(lat: -6.2088, lon: 106.8456)
                        }
                    )
                    .frame(height: 44) // Or remove this line if CustomBarView sizes itself sensibly
                }
            }
            .onAppear {
                // Auto-load data pas pertama kali aplikasi dibuka
                if presenter.weather == nil {
                    presenter.fetchData(lat: -6.2088, lon: 106.8456)
                }
            }
        }
    }
}
