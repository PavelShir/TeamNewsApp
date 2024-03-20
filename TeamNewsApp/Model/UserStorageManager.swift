//
//  UserStorageManager.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 20.03.2024.
//

import UIKit

final class UserStorageManager {
    
    static let shared = UserStorageManager()
    private var userDefaults = UserDefaults.standard
    private let key = "user"

    func saveUserData(_ user: User) {
        set(object: user, forKey: key)
    }
    
    func updateUserName(name: String) {
        guard var user = get(forKey: key) else { return }
        user.name = name
        set(object: user, forKey: key)
    }
    
    func updateUserPhoto(photo: UIImage) {
        guard var user = get(forKey: key) else { return }
        user.photo = ImageWrapper(image: photo)
        set(object: user, forKey: key)
    }
    
    func login(mail: String, password: String) -> Bool {
        guard let user = get(forKey: key) else { return false }
        if user.mail == mail && user.password == password {
            return true
        } else {
            return false
        }
    }
    
    func getUserData() -> User? {
        get(forKey: key)
    }
    
    private func set(object: User, forKey key: String) {
        let jsonData = try? JSONEncoder().encode(object)
        userDefaults.set(jsonData, forKey: key)
    }
    
    private func get(forKey key: String) -> User? {
        guard let data = userDefaults.object(forKey: key) as? Data else { return nil }
        return try? JSONDecoder().decode(User?.self, from: data)
    }
    
    
}
