//
//  ReservationRouter.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/07.
//

import Foundation
import Moya

enum ReservationRouter {
    case getReservationList(type: ReservationListResponseDTOElement.ReserveType, startTime: Date, endTime: Date)
    case getReservationDetail(reservationId: Int)
    case postReservation(data: ReservationPostRequestDTO)
    case putReservation(data: ReservationPutRequestDTO)
}

extension ReservationRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getReservationList, .postReservation, .putReservation:
            return "/reservation"
        case .getReservationDetail(let id):
            return "/reservation/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReservationList, .getReservationDetail:
            return .get
        case .postReservation:
            return .post
        case .putReservation:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getReservationList(let type, let startTime, let endTime):
            let body : [String: Any] = [
                "type" : type.rawValue,
                "startTime" : "\(startTime)",
                "endTime" : "\(endTime)",
            ]
            return .requestParameters(parameters: body, encoding: URLEncoding.default)
        case .getReservationDetail:
            return .requestPlain
        case .postReservation(let data):
            return .requestParameters(parameters: [
                ReservationPostRequestDTO.CodingKeys.receiverId.rawValue : data.receiverId,
                ReservationPostRequestDTO.CodingKeys.dateTime.rawValue : data.dateTime,
                ReservationPostRequestDTO.CodingKeys.content.rawValue : data.content
            ], encoding: JSONEncoding.prettyPrinted)
        case .putReservation(let data):
            let body: [String : Any] = [
                ReservationPutRequestDTO.CodingKeys.reservationId.rawValue : data.reservationId,
                ReservationPutRequestDTO.CodingKeys.type.rawValue : data.type,
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "accesstoken": UserInfo.shared.accessToken,
            ]
        }
    }
}
