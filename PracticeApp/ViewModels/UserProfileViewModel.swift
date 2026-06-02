//
//  UserProfileViewModel.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/18.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    
    @Published var user: User
    var onUserUpdated: ((User) -> Void)?
    
    init(user: User, onUserUpdated: ((User) -> Void)? = nil) {
        self.user = user
        self.onUserUpdated = onUserUpdated
    }
    
    func updateUser(_ newUser: User) async {
        user = newUser
        try? await LocalStorageManager().save(user, forKey: StorageKey.currentUser)
        onUserUpdated?(newUser)
    }
}
