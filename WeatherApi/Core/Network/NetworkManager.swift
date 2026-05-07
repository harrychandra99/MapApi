//
//  NetworkManager.swift
//  WeatherApi
//
//  Created by Kalvin on 17/03/26.
//
import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func loadAPI<T: Decodable>(url: URL) async throws -> T {
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
