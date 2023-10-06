//
//  ReviewRouter.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/09/02.
//

import Foundation
import Moya
import Alamofire

enum ReviewRouter {
    case getReviewList(userId: Int)
    case getReviewDetail(reviewId: Int)
    case postReview(data: ReviewPostRequestDTO)
    case deleteReview(data: ReviewDeleteRequestDTO)
}

extension ReviewRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
            case .getReviewList(let id):
            return "/review/user/\(id)"
            case .getReviewDetail(let id):
                return "/review/\(id)"
            case .postReview:
                return "/review"
            case .deleteReview(let id):
                return "/review/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReviewList, .getReviewDetail:
            return .get
        case .postReview:
            return .post
        case .deleteReview:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
            // TODO: [ERR] task 종류 보고 사용
        case .getReviewList:
            return .requestPlain
        case .getReviewDetail:
            return .requestPlain
        case .postReview(let data):
            let imageData = MultipartFormData(provider: .data(data.photo), name: "image", fileName: "image.png", mimeType: "image/png")
            let starData = MultipartFormData(provider: .data("\(data.star)".data(using: .utf8)!), name: ReviewPostRequestDTO.CodingKeys.star.rawValue)
            let idData = MultipartFormData(provider: .data("\(data.receiverId)".data(using: .utf8)!), name: ReviewPostRequestDTO.CodingKeys.receiverId.rawValue)
            let contentData = MultipartFormData(provider: .data(data.content.data(using: .utf8)!), name: ReviewPostRequestDTO.CodingKeys.content.rawValue)
            return .uploadMultipart([imageData, starData, idData, contentData])
        case .deleteReview(let data):
            let body: [String : Any] = [
                ReviewDeleteRequestDTO.CodingKeys.reviewId.rawValue : data.reviewId,
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postReview:
            return [
                "Content-Type": "multipart/form-data",
                "accesstoken": UserInfo.shared.accessToken,
            ]
        default:
            return [
                "Content-Type": "application/json",
                "accesstoken": UserInfo.shared.accessToken,
            ]
        }
    }
}
