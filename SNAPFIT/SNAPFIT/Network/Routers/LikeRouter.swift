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
}

extension LikeRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getLikeList:
            return "/like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLikeList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getLikeList:
            return .requestPlain
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
