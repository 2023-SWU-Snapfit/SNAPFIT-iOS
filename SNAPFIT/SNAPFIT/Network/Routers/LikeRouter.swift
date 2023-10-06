//
//  LikeRouter.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/09/01.
//

import Foundation
import Moya

enum LikeRouter {
    case getLikeList
    case postLike(targetId: Int)
}

extension LikeRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getLikeList, .postLike:
            return "/like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLikeList:
            return .get
        case .postLike:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getLikeList:
            return .requestPlain
        case .postLike(let targetId):
            let body : [String : Any] = [
                LikePutRequestDTO.CodingKeys.targetId.rawValue : targetId
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "accesstoken": UserInfo.shared.accessToken
            ]
        }
    }
}
