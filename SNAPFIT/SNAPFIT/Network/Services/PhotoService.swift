//
// PhotoService.swift
// SNAPFIT
//
// Created by Jungbin on 11/27/23.
//

import Foundation
import Moya

internal protocol PhotoServiceProtocol {
    func getPhotoByTag(tags: [Int], completion: @escaping (NetworkResult<Any>) -> (Void))
    func getMainPhoto(completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class PhotoService: BaseService {
    static let shared = PhotoService()
    private lazy var provider = SnapfitMoyaProvider<PhotoRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension PhotoService: PhotoServiceProtocol {
    
    // [GET] 태그별 사진 조회
    
    func getPhotoByTag(tags: [Int], completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getPhotoByTag(tags: tags)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, GetPhotoByTagResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // [GET] 메인 사진 조회
    
    func getMainPhoto(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getMainPhoto) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, GetMainTagPhotoResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
