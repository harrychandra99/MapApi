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
            headerSection
                .padding(.top, 40)
            tempSection
            
            VStack(spacing: 25) {
                VStack(spacing: 5) {
                    Text(weather.mainWeather)
                        .font(.title2).bold()
                    Text(weather.descriptionWeather)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                }
                HStack(spacing: 40) {
                    Label(weather.temperatureMin, systemImage: "arrow.down")
                        .font(.title3)
                    
                    Label(weather.temperatureMax, systemImage: "arrow.up")
                        .font(.title3)
                }
                .fontWeight(.medium)
                HStack(spacing: 15) {
                    DetailBox(title: "LATITUDE", value: "\(weather.latitude)")
                    DetailBox(title: "LONGITUDE", value: "\(weather.longitude)")
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            Button(action: onSave) {
                HStack {
                    Image(systemName: "folder.badge.plus")
                    Text("Save to Database")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
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



extension WeatherInfoView {
    private var headerSection: some View {
        VStack(spacing: 4) {
            Text(weather.cityName)
                .font(.system(size: 38, weight: .bold, design: .rounded))
            
            Text(weather.timezone)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var tempSection: some View {
        VStack(spacing: -10) {
            Image(systemName: weather.iconCodeWeather)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
            Text("\(weather.temperatureCurrent)°")
                .font(.system(size: 100, weight: .thin, design: .rounded))
        }
    }
}
