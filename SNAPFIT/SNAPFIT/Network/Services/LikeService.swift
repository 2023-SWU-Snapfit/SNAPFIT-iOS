//
//  LikeService.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/09/01.
//

import Foundation
import Moya

internal protocol LikeServiceProtocol {
    func getLikeList(completion: @escaping (NetworkResult<Any>) -> (Void))
    func postLike(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class LikeService: BaseService {
    static let shared = LikeService()
    private lazy var provider = SnapfitMoyaProvider<LikeRouter>(isLoggingOn: false)
    
    private override init() {}
}

extension LikeService: LikeServiceProtocol {
    // [GET] 좋아요 리스트
    
    func getLikeList(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getLikeList) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, LikeListResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    
    func postLike(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.postLike(targetId: targetId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, LikePutRequestDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    
}
