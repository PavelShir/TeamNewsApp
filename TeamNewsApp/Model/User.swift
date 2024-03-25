//
//  User.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 20.03.2024.
//

import UIKit

struct User: Codable {
    var name: String
    let mail: String
    let password: String
    var photo: ImageWrapper?
}

public struct ImageWrapper: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case image
    }
    
    public let image: UIImage
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        if let image = UIImage(data: data) {
            self.image = image
        } else {
            throw WrapperError.decodingError
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let imageData: Data = image.pngData() {
            try container.encode(imageData, forKey: .image)
        } else {
            throw WrapperError.encodingError
        }
    }
}

enum WrapperError: Error {
    case decodingError
    case encodingError
}
