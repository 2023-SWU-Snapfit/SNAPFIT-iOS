//
//  BlockService.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/04.
//

import Foundation
internal protocol BlockServiceProtocol {
    func postBlock(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class BlockService: BaseService {
    static let shared = BlockService()
    private lazy var provider = SnapfitMoyaProvider<BlockRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension BlockService: BlockServiceProtocol {
    func postBlock(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        self.provider.request(.postBlock(targetId: targetId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, BlockRequestDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
}
