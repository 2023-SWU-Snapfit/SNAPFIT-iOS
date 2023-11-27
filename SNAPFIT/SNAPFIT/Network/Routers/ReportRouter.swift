//
//  ReportUserRouter.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/04.
//

import Foundation
import Moya

enum ReportRouter {
    case postReport(targetId: Int)
}

extension ReportRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postReport:
            return "/report"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReport:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postReport(let targetId):
            let body : [String : Any] = [
                ReportRequestDTO.CodingKeys.targetId.rawValue : targetId
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
