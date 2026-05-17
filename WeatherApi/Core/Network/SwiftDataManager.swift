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
    
    func saveToDatabase<T: DataMappable, S>(input: S, as type: T.Type) -> Void where T.Source == S {
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
    
    func loadFromDatabase<T: PersistentModel>(sortBy: [SortDescriptor<T>] = []) -> [T]{
        guard let context = modelContext else {
//            print("❌ Error: ModelContext belum di-set di SwiftDataManager!")
            return []
        }
        
        let descriptor = FetchDescriptor<T>()
        do {
            let data = try context.fetch(descriptor)
//            print("✅ Berhasil memuat \(data.count) data dari tabel [\(T.self)]!")
            return data
        } catch {
            print("❌ Gagal melakukan fetch di SwiftDataManager: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteFromDatabase<T: PersistentModel>(object: T) {
        guard let context = modelContext else {
//            print("❌ Error: ModelContext belum di-set di SwiftDataManager!")
            return
        }
        
        context.delete(object)
        
        do {
            try context.save()
            print("✅ Berhasil menghapus data dari tabel [\(T.self)]!")
        } catch {
            print("❌ Gagal melakukan save setelah hapus di SwiftDataManager: \(error.localizedDescription)")
        }
    }
}

