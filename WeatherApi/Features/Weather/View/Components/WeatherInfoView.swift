//
//  WeatherInfoView.swift
//  WeatherApi
//
//  Created by Kalvin on 09/04/26.
//
import SwiftUI

struct WeatherInfoView: View {
    let weather: WeatherEntity
    var onSave: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Text(weather.cityName)
                    .font(.system(size: 34, weight: .medium, design: .rounded))
                
                Text(weather.timezone)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Image(systemName: weather.iconCodeWeather)
                    .resizable()
                    .symbolRenderingMode(.multicolor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text(weather.temperatureCurrent)
                    .font(.system(size: 90, weight: .thin, design: .rounded))
                
                VStack {
                    Text(weather.mainWeather)
                        .font(.title2).bold()
                    Text(weather.descriptionWeather)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top, 40)
            
            HStack(spacing: 40) {
                Label(weather.temperatureMin, systemImage: "arrow.down")
                    .font(.title3)
                
                Label(weather.temperatureMax, systemImage: "arrow.up")
                    .font(.title3)
            }
            .fontWeight(.medium)
            
            VStack(spacing: 15) {
                HStack {
                    DetailBox(title: "LATITUDE", value: "\(weather.latitude)")
                    DetailBox(title: "LONGITUDE", value: "\(weather.longtitude)")
                }
            }
            .padding(.horizontal)
            Spacer()
            
            VStack(spacing: 15) {
                Button("Save Button") {
                    onSave()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding(.horizontal)
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}
