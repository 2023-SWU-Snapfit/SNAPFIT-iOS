//
//  GetPhotoByTagResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/29/23.
//

import Foundation

// MARK: - GetPhotoByTagResponseDTO
struct GetPhotoByTagResponseDTO: Codable {
    let photoData: [Photo]

    enum CodingKeys: String, CodingKey {
        case photoData = "photoData"
    }
    
    // MARK: - PhotoDatum
    struct Photo: Codable {
        let id: Int
        let photoURL: String
        let userID: Int
        let createdAt: String
        let isDeleted: Bool
        let tag: [Int]
        let isPinned: Bool

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case photoURL = "photoUrl"
            case userID = "userId"
            case createdAt = "createdAt"
            case isDeleted = "isDeleted"
            case tag = "tag"
            case isPinned = "isPinned"
        }
    }
}
