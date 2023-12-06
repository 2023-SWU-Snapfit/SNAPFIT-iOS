//
//  SearchPhotoResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 12/6/23.
//

import Foundation

// MARK: - SearchPhotoResponseDTO
struct SearchPhotoResponseDTO: Codable {
    let photoData: [Photo]

    enum CodingKeys: String, CodingKey {
        case photoData = "photoData"
    }
    
    // MARK: - Photo
    struct Photo: Codable {
        let id: Int
        let userID: Int
        let nickname: String
        let photoURL: String
        let tag: [String]

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case userID = "userId"
            case nickname = "nickname"
            case photoURL = "photoUrl"
            case tag = "tag"
        }
    }

}
