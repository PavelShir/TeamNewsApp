//
//  UserStorageManager.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 20.03.2024.
//

import UIKit

final class UserStorageManager {
    
    static let shared = UserStorageManager()
    private static var currentUser: User?
    private var userDefaults = UserDefaults.standard
    private let key = "users"

    func saveNewUser(_ user: User) {
        UserStorageManager.currentUser = user
        if var users = get(forKey: key) {
            users.append(user)
            set(object: users, forKey: key)
        } else {
            set(object: [user], forKey: key)
        }
    }
    
    func updateUserName(name: String) {
        if var users = get(forKey: key) {
            if var currentUser = UserStorageManager.currentUser {
                let index = users.firstIndex(of: currentUser)
                currentUser.name = name
                UserStorageManager.currentUser = currentUser
                if let index {
                    users.remove(at: index)
                    users.insert(currentUser, at: index)
                    set(object: users, forKey: key)
                }
            }
        }
    }
    
    func updateUserPhoto(photoName: String) {
        if var users = get(forKey: key) {
            if var currentUser = UserStorageManager.currentUser {
                let index = users.firstIndex(of: currentUser)
                currentUser.photoName = photoName
                UserStorageManager.currentUser = currentUser
                if let index {
                    users.remove(at: index)
                    users.insert(currentUser, at: index)
                    set(object: users, forKey: key)
                }
            }
        }
    }
    
    func login(mail: String, password: String) -> Bool {
        if var users = get(forKey: key) {
            for user in users {
                if user.mail == mail && user.password == password {
                    UserStorageManager.currentUser = user
                    return true
                }
            }
            return false
        } else {
            return false
        }
    }
    
    func getUserData() -> User? {
        UserStorageManager.currentUser
    }
    
    private func set(object: [User], forKey key: String) {
        let jsonData = try? JSONEncoder().encode(object)
        userDefaults.set(jsonData, forKey: key)
    }
    
    private func get(forKey key: String) -> [User]? {
        guard let data = userDefaults.object(forKey: key) as? Data else { return nil }
        return try? JSONDecoder().decode([User]?.self, from: data)
    }
    
    
}
