//
//  User.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 20.03.2024.
//

import UIKit

struct User: Codable, Equatable {
    var name: String
    let mail: String
    let password: String
    var photoName: String?
}
