//
//  LocalStorageManager.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/18.
//

import Foundation

struct LocalStorageManager {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func deleteUser(forKey key: StorageKey) throws {
        let url = documentsDirectory.appendingPathComponent(key.rawValue)
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        try FileManager.default.removeItem(at: url)
    }
    
    func save<T: Encodable>(_ value: T, forKey key: StorageKey) async throws {
        let url = documentsDirectory.appendingPathComponent(key.rawValue)
        let data = try encoder.encode(value)
        try data.write(to: url)
    }
    
    func load<T: Decodable>(_ type: T.Type, forKey key: StorageKey) async throws -> T? {
        let url = documentsDirectory.appendingPathComponent(key.rawValue)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
}
