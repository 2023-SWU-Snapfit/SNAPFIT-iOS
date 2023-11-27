//
//  UserDetailResponseDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/17.
//

import Foundation
import UIKit

struct UserDetailResponseDTOElement: Codable {
    
    let userId: Int
    let profileImageUrl: String?
    var profileImage: UIImage? = nil
    let thumbnailImageUrl: String?
    var thumbnailImage: UIImage? = nil
    let likes: String
    let position: String
    let nickname: String
    let instagramId: String
    let email: String
    let info: String?
    let gallery: [Gallery]
    let averageStars: Float?
    let review: [UserReviewList]
    let cost: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case profileImageUrl = "profileImageUrl"
        case thumbnailImageUrl = "thumbnailImageUrl"
        case likes = "likes"
        case position = "position"
        case nickname = "nickname"
        case instagramId = "instagramId"
        case email = "email"
        case info = "info"
        case gallery = "gallery"
        case averageStars = "averageStars"
        case review = "review"
        case cost = "cost"
    }

}

struct Gallery: Codable {
    let id: Int
    let photoUrl: String
    let userId: Int
    let createdAt: String
    let isDeleted: Bool
    let tag: [Int]
    let isPinned: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photoUrl = "photoUrl"
        case userId = "userId"
        case createdAt = "createdAt"
        case isDeleted = "isDeleted"
        case tag = "tag"
        case isPinned = "isPinned"
    }
}

struct UserReviewList: Codable {
    let id: Int
    let star: Int
    let photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case star = "star"
        case photoUrl = "photoUrl"
    }
}

typealias UserDetailResponseDTO = UserDetailResponseDTOElement
