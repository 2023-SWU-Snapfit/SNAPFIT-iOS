//
//  ReviewPostRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/09/03.ss
//

import Foundation

struct ReviewPostRequestDTOElement: Codable {
    let star: Int
    let receiverId: Int
    let photo: Data
    let content: String

    enum CodingKeys: String, CodingKey {
        case star = "star"
        case receiverId = "receiverId"
        case photo = "image"
        case content = "content"
    }
    init(star: Int, receiverId: Int, photo: Data, content: String) {
        self.star = star
        self.receiverId = receiverId
        self.photo = photo
        self.content = content
    }
}

typealias ReviewPostRequestDTO = ReviewPostRequestDTOElement
