//
//  UserRepositoryProtocol.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [User]
    func fetchUsers() -> AnyPublisher<[User], Error>
    func saveUser(_ user: User) async throws
    func saveUser(_ user: User) -> AnyPublisher<Void, Error>
    func loadCurrentUser() async throws -> User?
    func loadCurrentUser() -> AnyPublisher<User?, Error>
    func deleteCurrentUser() throws
    func deleteCurrentUser() -> AnyPublisher<Void, Error>
}
