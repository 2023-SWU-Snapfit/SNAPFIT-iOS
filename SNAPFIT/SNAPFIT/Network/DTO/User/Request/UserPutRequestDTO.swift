//
//  UserPutRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/16.
//

import Foundation

struct UserPutRequestDTOElement: Codable {
    let profileImageUrl: Data
    let thumbnail: Data
    let nickname: String
    let instagramId: String
    let info: String
    let cost: String
    let contactUrl: String
    let onPush: Bool
    let availableTime: String
    
    enum CodingKeys: String, CodingKey {
        case profileImageUrl = "profileImageUrl"
        case thumbnail = "thumbnail"
        case nickname = "nickname"
        case instagramId = "instagramId"
        case info = "info"
        case cost = "cost"
        case contactUrl = "contactUrl"
        case onPush = "onPush"
        case availableTime = "availableTime"
    }
}

typealias UserPutRequestDTO = UserPutRequestDTOElement
