//
//  BlockRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/04.
//

import Foundation

struct BlockRequestDTOElement: Codable {
    let targetId: Int
    
    enum CodingKeys: String, CodingKey {
        case targetId = "targetId"
    }
}

typealias BlockRequestDTO = BlockRequestDTOElement
