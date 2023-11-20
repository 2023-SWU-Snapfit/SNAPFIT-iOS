//
//  ReservationListResponseDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/07.
//

import Foundation

struct ReservationListResponseDTOElement: Codable {
    let id: Int
    let dateTime: String
    let content: String
    let senderId: Int
    let receiverId: Int
    let isConfirmed: Bool
    let createdAt: String
    let isDeleted: Bool
    let updatedAt: String
    let isOpenUrl: Bool
    let senderNickname: String
    let receiverNickname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateTime = "dateTime"
        case content = "content"
        case senderId = "senderId"
        case receiverId = "receiverId"
        case isConfirmed = "isConfirmed"
        case createdAt = "createdAt"
        case isDeleted = "isDeleted"
        case updatedAt = "updatedAt"
        case isOpenUrl = "isOpenUrl"
        case senderNickname = "senderNickname"
        case receiverNickname = "receiverNickname"
    }
    
    enum ReserveType: String {
        case fixed = "fixed"
        case proceeding = "proceeding"
    }
}

typealias ReservationListResponseDTO = [ReservationListResponseDTOElement]
