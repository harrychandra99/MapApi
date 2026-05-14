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
    
    init() {
        let service = WeatherService()
        let stateObj = WeatherState()
        
        guard let context = SwiftDataManager.shared.modelContext else {
            fatalError("❌ Error: SwiftData context is missing!")
        }
        
        let presenterObj = WeatherPresenter(service: service, modelContext: context)
        presenterObj.view = stateObj
        
        self.presenter = presenterObj
        self._state = StateObject(wrappedValue: stateObj)
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top){
                backgroundLayer
                
                mainContent
                    .blur(radius: !state.cityResults.isEmpty ? 3 : 0)
                    .animation(.spring, value: state.cityResults.isEmpty)
                
                if !state.cityResults.isEmpty {
                    citySearchOverlay
                        .padding(.top, 10)
                        .zIndex(1)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CustomToolBarView(
                        onSearch: {query in
                            self.searchText = query},
                        onLocation: {
                            presenter.startLocationRequest()
                        }
                    )
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                }
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    state.cityResults = []
                } else {
                    presenter.searchCity(name: newValue)
                    print(newValue)
                }
            })
            .onAppear {
                if case.idle = state.currentState{
                    presenter.fetchDataWeather(lat: -6.2088, lon: 106.8456)
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
    private var backgroundLayer: some View {
        LinearGradient(colors: [.blue.opacity(0.1), .white], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var mainContent: some View {
        VStack {
            switch state.currentState {
            case.idle:
                ContentUnavailableView("Search City",
                                       systemImage: "magnifyingglass",
                                       description: Text("Start by searching or using your location")
                )
                
            case.loading:
                loadingOverLay
            case.success(let weather):
                WeatherInfoView(weather: weather) {
                    presenter.saveToDatabase(apiData: weather)
                    showSaveAlert = true
                }
                .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .bottom)),
                                        removal: .opacity
                                       ))
            case.error(let message):
                errorView(message: message)
            }
        }
        .animation(.easeInOut, value: state.currentState)
    }
    
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
    
    private var citySearchOverlay: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(state.cityResults, id: \.self) { city in
                        Button {
                            presenter.fetchDataWeather(lat: city.lat, lon: city.lon)
                            state.cityResults = []
                            self.searchText = ""
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(city.name).fontWeight(.bold).foregroundColor(.primary)
                                    Text("\(city.state ?? ""), \(city.country)").font(.caption).foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "mappin.and.ellipse").foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color(.systemBackground).opacity(0.8))
                        }
                        Divider().padding(.horizontal)
                    }
                }
            }
            .frame(maxHeight: state.cityResults.count > 4 ? 300 : CGFloat(state.cityResults.count * 70))
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding(.horizontal)
            Spacer()
        }
        .zIndex(10)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    private func errorView(message: String) -> some View{
        VStack(spacing: 15) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Try Again") {
                presenter.fetchDataWeather(lat: -6.2, lon: 106.8)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
