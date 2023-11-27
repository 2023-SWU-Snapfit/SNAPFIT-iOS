//
//  LikePutRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/05.
//

import Foundation

struct LikePutRequestDTOElement: Codable {
    let targetId: Int
    
    enum CodingKeys: String, CodingKey {
        case targetId = "targetId"
    }
}

typealias LikePutRequestDTO = LikePutRequestDTOElement
