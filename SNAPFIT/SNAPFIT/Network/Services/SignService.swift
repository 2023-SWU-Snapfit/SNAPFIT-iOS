//
//  SignService.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/15/23.
//

import Foundation
import Moya

internal protocol SignServiceProtocol {
    func requestSignIn(data: SignInRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func verifyPhoneNumber(data: VerifyPhoneNumberRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func checkNickname(data: String, completion: @escaping (NetworkResult<Any>) -> (Void))
    func checkEmail(data: String, completion: @escaping (NetworkResult<Any>) -> (Void))
    func requestSignUp(data: SignUpRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class SignService: BaseService {
    static let shared = SignService()
    private lazy var provider = SnapfitMoyaProvider<SignRouter>(isLoggingOn: false)
    
    private override init() {}
}

extension SignService: SignServiceProtocol {
    
    // [POST] 로그인
    
    func requestSignIn(data: SignInRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestSignIn(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, SignInResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // [POST] 휴대폰 번호 인증
    
    func verifyPhoneNumber(data: VerifyPhoneNumberRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.verifyPhoneNumber(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // [POST] 닉네임 중복 체크
    
    func checkNickname(data: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.checkNickname(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // [POST] 이메일 중복 체크
    
    func checkEmail(data: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.checkEmail(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // [POST] 회원가입 요청
    
    func requestSignUp(data: SignUpRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestSignUp(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
