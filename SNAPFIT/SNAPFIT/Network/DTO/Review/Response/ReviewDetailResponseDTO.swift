//
//  ReviewDetailResponseDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/09/03.
//

import Foundation

struct ReviewDetailResponseDTOElement: Codable {
    let id: Int
    let star: Int
    let senderId: Int
    let receiverId: Int
    let createdAt: String
    let isDeleted: Bool
    let updatedAt: String
    let photoUrl: String
    let content: String?
    let sender: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case star = "star"
        case senderId = "senderId"
        case receiverId = "receiverId"
        case createdAt = "createdAt"
        case isDeleted = "isDeleted"
        case updatedAt = "updatedAt"
        case photoUrl = "photoUrl"
        case content = "content"
        case sender = "sender"
    }
}

typealias ReviewDetailResponseDTO = ReviewDetailResponseDTOElement
