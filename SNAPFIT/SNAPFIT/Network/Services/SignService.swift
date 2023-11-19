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
}