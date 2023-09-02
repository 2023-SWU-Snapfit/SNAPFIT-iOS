//
//  LikeListResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/09/01.
//

import Foundation

// MARK: - LikeListResponseDTOElement
struct LikeListResponseDTOElement: Codable {
    let id: Int
    let targetID: Int
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case targetID = "targetId"
        case userID = "userId"
    }
}

typealias LikeListResponseDTO = [LikeListResponseDTOElement]
