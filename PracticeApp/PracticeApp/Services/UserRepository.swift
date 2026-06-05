//
//  UserRepository.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation
import Combine

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
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        guard let url = URL(string: "\(baseURL)/users") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: UserArray.self, decoder: JSONDecoder())
            .map(\.users)
            .eraseToAnyPublisher()
    }
    
    func saveUser(_ user: User) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            Task {
                do {
                    try await storage.save(user, forKey: StorageKey.currentUser)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func loadCurrentUser() -> AnyPublisher<User?, Error> {
        Future<User?, Error> { promise in
            Task {
                do {
                    let user = try await storage.load(User.self, forKey: StorageKey.currentUser)
                    promise(.success(user))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteCurrentUser() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            do {
                try storage.deleteUser(forKey: StorageKey.currentUser)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

// MARK: - Async/await backward compatibility
extension UserRepository {
    func fetchUsers() async throws -> [User] {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = fetchUsers()
                .sink(
                    receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            continuation.resume(throwing: error)
                        }
                        _ = cancellable
                    },
                    receiveValue: { users in
                        continuation.resume(returning: users)
                        _ = cancellable
                    }
                )
        }
    }
    
    func saveUser(_ user: User) async throws {
        _ = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            var cancellable: AnyCancellable?
            cancellable = saveUser(user)
                .sink(
                    receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            continuation.resume(throwing: error)
                        }
                        _ = cancellable
                    },
                    receiveValue: {
                        continuation.resume()
                        _ = cancellable
                    }
                )
        }
    }
    
    func loadCurrentUser() async throws -> User? {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = loadCurrentUser()
                .sink(
                    receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            continuation.resume(throwing: error)
                        }
                        _ = cancellable
                    },
                    receiveValue: { user in
                        continuation.resume(returning: user)
                        _ = cancellable
                    }
                )
        }
    }
    
    func deleteCurrentUser() throws {
        var thrownError: Error?
        var cancellable: AnyCancellable?
        cancellable = deleteCurrentUser()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        thrownError = error
                    }
                    _ = cancellable
                },
                receiveValue: { _ = cancellable }
            )
        if let error = thrownError {
            throw error
        }
    }
}
