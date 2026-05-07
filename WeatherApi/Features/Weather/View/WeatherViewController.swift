//
//  ContentView.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI
import SwiftData

struct WeatherViewController: View {
    
    @State var searchText = ""
    @State private var showSaveAlert = false
    
    
    @StateObject private var state = WeatherState()
    
    private var presenter: WeatherPresenter
    
    init(modelContext: ModelContext) {
        let service = WeatherService()
        let stateObj = WeatherState()
        let presenterObj = WeatherPresenter(service: service, modelContext: modelContext)
        
        presenterObj.view = stateObj
        
        self.presenter = presenterObj
        self._state = StateObject(wrappedValue: stateObj)
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(colors: [.blue.opacity(0.1), .white], startPoint: .top, endPoint: .bottom)
                VStack{
                    if let weather = state.weather {
                        WeatherInfoView(weather: weather){
                            presenter.saveToDatabase(apiData: weather)
                            showSaveAlert = true
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    else if let error = state.errorMessage {
                        errorView(message: error)
                        
                    } else if !state.isLoading {
                        ContentUnavailableView("Search City",
                                               systemImage: "magnifyingglass",
                                               description: Text("Start by searching or using your location"))
                    }
                    
                }
                .blur(radius: state.isLoading ? 3 : 0)
                .animation(.easeInOut, value: state.isLoading)
                
                if state.isLoading {
                    loadingOverLay
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CustomToolBarView(
                        onSearch: {query in
                            self.searchText = query},
                        onLocation: {
                            presenter.startLocationRequest()
                        }
                        
                    )
                }
            }
            .onAppear {
                if state.weather == nil && !state.isLoading {
                    presenter.fetchData(lat: -6.2088, lon: 106.8456)
                }
            }
            .alert("Saved", isPresented: $showSaveAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Weather data has been added to your saved data.")
            }
        }
    }
}

extension WeatherViewController {
    private var loadingOverLay: some View{
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
    
    private func errorView(message: String) -> some View{
        VStack(spacing: 15) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Try Again") {
                presenter.fetchData(lat: -6.2, lon: 106.8)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
