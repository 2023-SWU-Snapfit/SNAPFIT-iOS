//
//  ReviewDeleteRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/09/03.
//

import Foundation

struct ReviewDeleteRequestDTOElement: Codable {
    let reviewId: Int

    enum CodingKeys: String, CodingKey {
        case reviewId = "reviewId"
    }
}

typealias ReviewDeleteRequestDTO = ReviewDeleteRequestDTOElement
