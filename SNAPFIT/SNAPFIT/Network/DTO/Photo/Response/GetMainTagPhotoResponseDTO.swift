//
//  GetMainTagPhotoResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/29/23.
//

import Foundation

// MARK: - GetMainTagPhotoResponseDTO
struct GetMainTagPhotoResponseDTO: Codable {
    let tagPhoto: [TagPhoto]
    let personal: [Personal]
    let season: [Personal]

    enum CodingKeys: String, CodingKey {
        case tagPhoto = "tagPhoto"
        case personal = "personal"
        case season = "season"
    }
    
    // MARK: - Personal
    struct Personal: Codable {
        let id: Int
        let photoURL: String
        let tag: [String]
        let userID: Int
        let nickname: String

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case photoURL = "photoUrl"
            case tag = "tag"
            case userID = "userId"
            case nickname = "nickname"
        }
    }

    // MARK: - TagPhoto
    struct TagPhoto: Codable {
        let tagName: String
        let photos: [Photo]

        enum CodingKeys: String, CodingKey {
            case tagName = "tagName"
            case photos = "photos"
        }
    }

    // MARK: - Photo
    struct Photo: Codable {
        let id: Int
        let photoURL: String
        let userID: Int
        let createdAt: String
        let isDeleted: Bool
        let tag: [String]
        let isPinned: Bool
        let nickname: String

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case photoURL = "photoUrl"
            case userID = "userId"
            case createdAt = "createdAt"
            case isDeleted = "isDeleted"
            case tag = "tag"
            case isPinned = "isPinned"
            case nickname = "nickname"
        }
    }

}
