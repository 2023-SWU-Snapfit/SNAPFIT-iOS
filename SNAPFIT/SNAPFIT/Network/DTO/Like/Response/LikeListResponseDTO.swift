//
//  LikeListResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/09/01.
//

import Foundation

// MARK: - LikeListResponseDTOElement
struct LikeListResponseDTOElement: Codable {
    let targetID: Int
    let nickname: String
    let profileImageUrl: String?
    let position: String

    enum CodingKeys: String, CodingKey {
        case targetID = "targetId"
        case nickname = "nickname"
        case profileImageUrl = "profileImageUrl"
        case position = "position"
    }
}

typealias LikeListResponseDTO = [LikeListResponseDTOElement]
