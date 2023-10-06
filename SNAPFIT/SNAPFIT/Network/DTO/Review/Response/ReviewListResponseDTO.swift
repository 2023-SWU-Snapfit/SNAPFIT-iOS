    //
//  ReviewListResponseDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/09/03.
//

import Foundation

struct ReviewListResponseDTOElement: Codable {
    let id: Int
    let star: Int
    let photoUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case star = "star"
        case photoUrl = "photoUrl"
    }
}

typealias ReviewListResponseDTO = [ReviewListResponseDTOElement]
