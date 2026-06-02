//
//  UserRepository.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation

struct UserRepository: UserRepositoryProtocol {
    private let baseURL: String
    private let storage: LocalStorageManager
    
    init(
        baseURL: String = "https://dummyjson.com",
        storage: LocalStorageManager = LocalStorageManager()
    ) {
        self.baseURL = baseURL
        self.storage = storage
    }
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "\(baseURL)/users") else {
            throw URLError(.badURL)
        }
        let(data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(UserArray.self, from: data)
        return response.users
    }
    
    func saveUser(_ user: User) async throws {
        try await storage.save(user, forKey: StorageKey.currentUser)
    }
    
    func loadCurrentUser() async throws -> User? {
        try await storage.load(User.self, forKey: StorageKey.currentUser)
    }
    
    func deleteCurrentUser() throws {
        try storage.deleteUser(forKey: StorageKey.currentUser)
    }
}
