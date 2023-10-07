//
//  ReviewService.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/09/02.
//

import Foundation
import Moya

internal protocol ReviewServiceProtocol {
    func getReviewList(userId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
    func getReviewDetail(reviewId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
    func postReview(data: ReviewPostRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func deleteReview(reviewId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class ReviewService: BaseService {
    static let shared = ReviewService()
    private lazy var provider = SnapfitMoyaProvider<ReviewRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension ReviewService: ReviewServiceProtocol {
    
    /// 특정 사용자의 리뷰 목록을 조회( id,  star, photoUrl )
    /// 마이페이지나 프로필에서 띄워주는 정보만 제공.
    func getReviewList(userId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getReviewList(userId: userId)) { result in
            switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    let data = response.data
                    let networkResult = self.judgeStatus(by: statusCode, data, ReviewListResponseDTO.self)
                    completion(networkResult)
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    
    /// 특정 리뷰 하나에 대한 모든 정보를 조회
    /// 리뷰 상세 뷰에서 사용
    func getReviewDetail(reviewId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getReviewDetail(reviewId: reviewId)) { result in
            switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    let data = response.data
                    let networkResult = self.judgeStatus(by: statusCode, data, ReviewDetailResponseDTO.self)
                    completion(networkResult)
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    
    /// 리뷰 작성 요청
    func postReview(data: ReviewPostRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.postReview(data: data)) { result in
            switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    let data = response.data
                    let networkResult = self.judgeStatus(by: statusCode, data, ReviewPostRequestDTO.self)
                    completion(networkResult)
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    
    /// 리뷰 삭제 요청
    func deleteReview(reviewId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.deleteReview(data: ReviewDeleteRequestDTO(reviewId: reviewId))) { result in
            switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    let data = response.data
                    let networkResult = self.judgeStatus(by: statusCode, data, ReviewDeleteRequestDTO.self)
                    completion(networkResult)
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
}
