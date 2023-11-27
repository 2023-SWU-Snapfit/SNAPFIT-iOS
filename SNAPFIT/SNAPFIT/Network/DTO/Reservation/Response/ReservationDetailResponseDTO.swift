//
//  ReservationDetailResponseDTO.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/07.
//

import Foundation

struct ReservationDetailResponseDTOElement: Codable {
    let id: Int
    let dateTime: String
    let content: String
    let senderId: Int
    let senderNickname: String
    let senderProfileImageUrl: String?
    let receiverId: Int
    let receiverNickname: String
    let receiverProfileImageUrl: String?
    let isConfirmed: Bool
    let isOpenUrl: Bool
    let contactUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateTime = "dateTime"
        case content = "content"
        case sender = "sender"
        case receiver = "receiver"
        case isConfirmed = "isConfirmed"
        case isOpenUrl = "isOpenUrl"
        case contactUrl = "contactUrl"
    }
    
    enum UserCodingKeys: String, CodingKey {
        case id = "id"
        case nickname = "nickname"
        case profileImageUrl = "profileImageUrl"
    }
    
}

typealias ReservationDetailResponseDTO = ReservationDetailResponseDTOElement

extension ReservationDetailResponseDTOElement {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.dateTime = try container.decode(String.self, forKey: .dateTime)
        self.content = try container.decode(String.self, forKey: .content)
        self.isConfirmed = try container.decode(Bool.self, forKey: .isConfirmed)
        self.isOpenUrl = try container.decode(Bool.self, forKey: .isOpenUrl)
        self.contactUrl = try container.decode(String.self, forKey: .contactUrl)
        
        let receiverData = try container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .receiver)
        self.receiverId = try receiverData.decode(Int.self, forKey: .id)
        self.receiverNickname = try receiverData.decode(String.self, forKey: .nickname)
        self.receiverProfileImageUrl = try? receiverData.decode(String.self, forKey: .profileImageUrl)
        let senderData = try container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .sender)
        self.senderId = try senderData.decode(Int.self, forKey: .id)
        self.senderNickname = try senderData.decode(String.self, forKey: .nickname)
        self.senderProfileImageUrl = try? senderData.decode(String.self, forKey: .profileImageUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(dateTime, forKey: .dateTime)
        try container.encode(content, forKey: .content)
        try container.encode(isConfirmed, forKey: .isConfirmed)
        try container.encode(isOpenUrl, forKey: .isOpenUrl)
        try container.encode(contactUrl, forKey: .contactUrl)
        var receiverContainer = container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .receiver)
        try receiverContainer.encode(receiverId, forKey: .id)
        try receiverContainer.encode(receiverNickname, forKey: .nickname)
        try receiverContainer.encode(receiverProfileImageUrl, forKey: .profileImageUrl)
        var senderContainer = container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .sender)
        try senderContainer.encode(senderId, forKey: .id)
        try senderContainer.encode(senderNickname, forKey: .nickname)
        try senderContainer.encode(senderProfileImageUrl, forKey: .profileImageUrl)
    }
}
