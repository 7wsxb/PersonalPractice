//
//  UserService.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/24.
//

import Foundation

struct UserService {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func loadCurrentUser() async throws -> User {
        if let currentUser = try await repository.loadCurrentUser() {
            return currentUser
        }
        let user = try await repository.fetchUsers()[7]
        try await repository.saveUser(user)
        return user
    }
    
    func updateUser(_ user: User) async throws {
        try await repository.saveUser(user)
    }
}
