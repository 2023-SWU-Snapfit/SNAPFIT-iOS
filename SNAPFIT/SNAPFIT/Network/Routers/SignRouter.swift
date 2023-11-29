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
    case checkEmail(data: String)
    case checkNickname(data: String)
    case requestSignUp(data: SignUpRequestDTO)
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
        case .checkEmail:
            return "/auth/duplication-check/email"
        case .checkNickname:
            return "/auth/duplication-check/nickname"
        case .requestSignUp:
            return "/auth/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestSignIn, .verifyPhoneNumber, .checkEmail, .checkNickname, .requestSignUp:
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
        case .checkNickname(let data):
            let body: [String: Any] = [
                "nickname": data
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        case .checkEmail(let data):
            let body: [String: Any] = [
                "email": data
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        case .requestSignUp(let data):
            var formData: [MultipartFormData] = []
            debugPrint(data)
            if let imageData = data.profileImageUrl.pngData() {
                let imageFormData = MultipartFormData(provider: .data(imageData), name: "profileImageUrl", fileName: "profileImage\(Date()).png", mimeType: "image/png")
                formData.append(imageFormData)
            } else {
                print("Failed to convert UIImage to Data.")
            }
            
            formData.append(MultipartFormData(provider: .data("\(data.email)".data(using: .utf8)!), name: "email"))
            formData.append(MultipartFormData(provider: .data("\(data.nickname)".data(using: .utf8)!), name: "nickname"))
            formData.append(MultipartFormData(provider: .data("\(data.password)".data(using: .utf8)!), name: "password"))
            formData.append(MultipartFormData(provider: .data("\(data.instagramId)".data(using: .utf8)!),name: "instagramId"))
            formData.append(MultipartFormData(provider: .data("\(data.cost)".data(using: .utf8)!), name: "cost"))
            formData.append(MultipartFormData(provider: .data("\(data.position)".data(using: .utf8)!), name: "position"))
            formData.append(MultipartFormData(provider: .data("\(data.contactUrl)".data(using: .utf8)!), name: "contactUrl"))
            formData.append(MultipartFormData(provider: .data(data.interest.makeFormDataString().data(using: .utf8)!), name: "interest"))
            
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .requestSignUp:
            return [
                "Content-Type": "multipart/form-data"
            ]
        case .requestSignIn, .verifyPhoneNumber, .checkEmail, .checkNickname:
            return ["Content-Type": "application/json"]
        }
    }
}
