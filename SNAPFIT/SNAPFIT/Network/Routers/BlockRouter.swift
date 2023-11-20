//
//  BlockUserRouter.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/04.
//

import Foundation
import Moya

enum BlockRouter {
    case postBlock(targetId: Int)
}

extension BlockRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postBlock:
            return "/block"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postBlock:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postBlock(let targetId):
            let body : [String : Any] = [
                BlockRequestDTO.CodingKeys.targetId.rawValue : targetId
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
