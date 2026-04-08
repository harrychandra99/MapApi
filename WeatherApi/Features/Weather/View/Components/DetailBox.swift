//
//  DetailBox.swift
//  WeatherApi
//
//  Created by Kalvin on 09/04/26.
//

import SwiftUI

struct DetailBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.5))
        .cornerRadius(12)
    }
}
