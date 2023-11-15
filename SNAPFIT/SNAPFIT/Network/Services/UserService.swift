//
//  UserService.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/16.
//

import Foundation
internal protocol UserServiceProtocol {
    func putUser(targetId: Int, data: UserPutRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func getUserList(input: String, limit: Int?, completion: @escaping (NetworkResult<Any>) -> (Void))
    func getUserDetail(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class UserService: BaseService {
    static let shared = UserService()
    private lazy var provider = SnapfitMoyaProvider<UserRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension UserService: UserServiceProtocol {
    
    func putUser(targetId: Int, data: UserPutRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        self.provider.request(.putUser(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, UserPutRequestDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    func getUserList(input: String, limit: Int?, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getUserList(input: input, limit: limit)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, UserListResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getUserDetail(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getUserDetail(targetId: targetId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, UserDetailResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
}
