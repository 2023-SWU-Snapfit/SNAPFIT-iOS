//
//  SignInResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/15/23.
//

import Foundation

// MARK: - SignInResponseDTO

struct SignInResponseDTO: Codable {
    let user: User
    let accesstoken: String

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case accesstoken = "accesstoken"
    }
    
    // MARK: - User
    struct User: Codable {
        let userID: Int
        let nickname: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case nickname = "nickname"
        }
    }
}
