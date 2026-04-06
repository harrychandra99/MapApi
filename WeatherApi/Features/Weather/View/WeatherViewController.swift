//
//  ContentView.swift
//  WeatherApi
//
//  Created by Kalvin on 20/11/25.
//

import SwiftUI

struct WeatherViewController: View {
    
    @State var searchText = ""
    @StateObject var adapter = WeatherViewAdapter()
    
    var presenter: WeatherPresenterProtocol?
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack{
                    Text(adapter.cityName)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(adapter.temperature)
                        .font(.system(size: 70))
                        .fontWeight(.thin)
                    
                    Text(adapter.condition)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()
                
                if adapter.isLoading {
                    ProgressView("Fetching Weather...")
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
            }
            
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
