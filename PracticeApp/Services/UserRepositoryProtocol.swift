//
//  UserRepositoryProtocol.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [User]
    func saveUser(_ user: User) async throws
    func loadCurrentUser() async throws -> User?
    func deleteCurrentUser() throws
}
