//
//  UserRouter.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/16.
//

import Foundation
import Moya

enum UserRouter {
    case putUser(data: UserPutRequestDTO)
    case getUserList(input: String, limit: Int?)
    case getUserDetail(targetId: Int)
}

extension UserRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .putUser, .getUserList:
            return "/user"
        case .getUserDetail(targetId: let targetId):
            return "/user/\(targetId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .putUser:
            return .put
        case .getUserList, .getUserDetail:
              return  .get
        }
    }
    
    var task: Task {
        switch self {
        case .putUser(let data):
            let profileImageUrlData = MultipartFormData(
                provider: .data(data.profileImageUrl), name: UserPutRequestDTO.CodingKeys.profileImageUrl.rawValue, fileName: "image1.png", mimeType: "image/png")
            let thumbnailData = MultipartFormData(
                provider: .data(data.thumbnail), name: UserPutRequestDTO.CodingKeys.thumbnail.rawValue, fileName: "image2.png", mimeType: "image/png")
            let nicknameData = MultipartFormData(
                provider: .data(data.nickname.data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.nickname.rawValue)
            let instagramIdData = MultipartFormData(
                provider: .data(data.instagramId.data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.instagramId.rawValue)
            let infoData = MultipartFormData(
                provider: .data(data.info.data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.info.rawValue)
            let costData = MultipartFormData(
                provider: .data(data.cost.data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.cost.rawValue)
            let contactUrlData = MultipartFormData(
                provider: .data(data.contactUrl.data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.contactUrl.rawValue)
            let onPushData = MultipartFormData(
                provider: .data("\(data.onPush)".data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.onPush.rawValue)
            let availableTimeData = MultipartFormData(
                provider: .data(data.availableTime.data(using: .utf8)!), name: UserPutRequestDTO.CodingKeys.availableTime.rawValue)
            return .uploadMultipart([profileImageUrlData, thumbnailData, nicknameData,  instagramIdData, infoData, costData, contactUrlData, onPushData,  availableTimeData,
            ])
        case .getUserList(let input, let limit):
            let body: [String : Any] = [
                UserListResponseDTOElement.QueryKeys.input.rawValue : input,
                UserListResponseDTOElement.QueryKeys.limit.rawValue : limit! > 0 ? Int(limit!) : nil
            ]
            return .requestParameters(parameters: body, encoding: URLEncoding.queryString)
        case .getUserDetail:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .putUser:
            return [
                "Content-Type": "multipart/form-data",
                "accesstoken": UserInfo.shared.accessToken
            ]
        default:
            return [
                "Content-Type": "application/json",
                "accesstoken": UserInfo.shared.accessToken
            ]
        }
    }
}
