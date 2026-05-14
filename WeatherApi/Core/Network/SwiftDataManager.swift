//
//  SwiftDataManager.swift
//  WeatherApi
//
//  Created by Kalvin on 13/05/26.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataManager {
    static let shared = SwiftDataManager()
    var modelContext: ModelContext?
    
    private init() {}
    
    func saveToDatabase<T: DataMappable, S>(input: S, as type: T.Type) where T.Source == S {
        guard let context = modelContext else {
            print("❌ Error: ModelContext belum di-set di SwiftDataManager!")
            return
        }
        
        let persistentObject = T.mapFrom(input)
        
        context.insert(persistentObject)
        
        do {
            try context.save()
            print("✅ Berhasil menyimpan tabel [\(T.self)]!")
        } catch {
            print("❌ Gagal melakukan save di SwiftDataManager: \(error.localizedDescription)")
        }
        
    }
    
}
