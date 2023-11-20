//
//  ReservationPostRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/05.
//

import Foundation

struct ReservationPostRequestDTOElement: Codable {
    let receiverId: Int
    let dateTime: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case receiverId = "receiverId"
        case dateTime = "dateTime"
        case content = "content"
    }

    
    init(receiverId: Int, dateTime: Date, content: String) {
        self.receiverId = receiverId
        self.dateTime = "\(dateTime)"
        self.content = content
    }
}

typealias ReservationPostRequestDTO = ReservationPostRequestDTOElement
