//
//  GetTopUsersResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 12/4/23.
//

import Foundation

struct GetTopUsersResponseDTO: Codable {
    let id: Int
    let profileImageURL: String?
    let nickname: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profileImageURL = "profileImageUrl"
        case nickname = "nickname"
    }
}
