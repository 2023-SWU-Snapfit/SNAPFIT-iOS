//
//  SignRouter.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/15/23.
//

import Foundation
import Moya

enum SignRouter {
    case requestSignIn(data: SignInRequestDTO)
}

extension SignRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestSignIn:
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestSignIn:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestSignIn(let data):
            let body: [String: Any] = [
                "email": data.email,
                "password": data.password,
                "deviceToken": data.deviceToken
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .requestSignIn:
            return ["Content-Type": "application/json"]
        }
    }
}
