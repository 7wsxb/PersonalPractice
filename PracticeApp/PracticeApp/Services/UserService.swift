//
//  UserService.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/24.
//

import Foundation
import Combine

struct UserService {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func loadCurrentUser() -> AnyPublisher<User, Error> {
        repository.loadCurrentUser()
            .flatMap { cachedUser -> AnyPublisher<User, Error> in
                if let cachedUser = cachedUser {
                    return Just(cachedUser)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                return repository.fetchUsers()
                    .map { $0[7] }
                    .flatMap { user in
                        repository.saveUser(user)
                            .map { user }
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func updateUser(_ user: User) -> AnyPublisher<Void, Error> {
        repository.saveUser(user)
    }
}

// MARK: - Async/await backward compatibility
extension UserService {
    func loadCurrentUser() async throws -> User {
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
    
    func updateUser(_ user: User) async throws {
        _ = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            var cancellable: AnyCancellable?
            cancellable = updateUser(user)
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
}
