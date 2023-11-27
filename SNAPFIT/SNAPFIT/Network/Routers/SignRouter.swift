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
    case verifyPhoneNumber(data: VerifyPhoneNumberRequestDTO)
}

extension SignRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestSignIn:
            return "/auth/login"
        case .verifyPhoneNumber:
            return "/auth/sms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestSignIn, .verifyPhoneNumber:
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
        case .verifyPhoneNumber(let data):
            let body: [String: Any] = [
                "phoneNumber": data.phoneNumber
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .requestSignIn, .verifyPhoneNumber:
            return ["Content-Type": "application/json"]
        }
    }
}
