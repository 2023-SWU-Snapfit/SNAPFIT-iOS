//
//  SignUpResponseDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/29/23.
//

import Foundation

struct SignUpResponseDTO: Codable {
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
    }
}
