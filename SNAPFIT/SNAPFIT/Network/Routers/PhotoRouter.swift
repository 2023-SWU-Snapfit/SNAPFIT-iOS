//
// PhotoRouter.swift
// SNAPFIT
//
// Created by Jungbin on 11/27/23.
//

import Foundation
import Moya

enum PhotoRouter {
    case getPhotoByTag(tags: [Int])
    case getMainPhoto
    case searchPhoto(keyword: String)
}

extension PhotoRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPhotoByTag(let tags):
            var tagPath = "/photo/tag/{"
            for i in tags {
                tagPath += "\(i),"
            }
            tagPath.removeLast()
            tagPath += "}"
            
            return tagPath
        case .getMainPhoto:
            return "/photo/main"
        case .searchPhoto:
            return "/photo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotoByTag, .getMainPhoto, .searchPhoto:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPhotoByTag, .getMainPhoto:
            return .requestPlain
        case .searchPhoto(let keyword):
            return .requestParameters(parameters: ["input": keyword, "limit": 5], encoding: URLEncoding.queryString)
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
