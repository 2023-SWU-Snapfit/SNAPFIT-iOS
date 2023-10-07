//
//  ReservationPutRequestDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/07.
//

import Foundation

struct ReservationPutRequestDTOElement: Codable {
    let reservationId: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case reservationId = "reservationId"
        case type = "type"
    }
    
    enum AllowingType: String {
        case url = "url"
        case confirm = "confirm"
    }
    
    init(reservationId: Int, type: AllowingType) {
        self.reservationId = reservationId
        self.type = type.rawValue
    }
}

typealias ReservationPutRequestDTO = ReservationPutRequestDTOElement
