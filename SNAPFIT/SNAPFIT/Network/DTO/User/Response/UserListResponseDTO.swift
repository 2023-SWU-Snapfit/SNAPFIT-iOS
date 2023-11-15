//
//  UserListRespondDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/17.
//

import Foundation

struct UserListResponseDTOElement: Codable {
    let userData: [UserForList]
    
    enum CodingKeys: String, CodingKey {
        case userData  = "userData"
    }
    
    enum QueryKeys: String {
        case input = "input"
        case limit = "limit"
    }
}

struct UserForList: Codable {
    
    let id: Int
    let profileImageUrl: String?
    let position: String
    let nickname: String
    let instagramId: String?
    let email: String?
    let info: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profileImageUrl = "profileImageUrl"
        case position = "position"
        case nickname = "nickname"
        case instagramId = "instagramId"
        case email = "email"
        case info = "info"
    }
    
}

typealias UserListResponseDTO = UserListResponseDTOElement
