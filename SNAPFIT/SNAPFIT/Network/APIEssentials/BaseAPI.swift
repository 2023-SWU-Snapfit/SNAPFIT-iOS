//
//  BaseAPI.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/10.
//

import Foundation
import Moya

class BaseAPI {
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(BaseResponseType<T>.self, from: data)
                
        else { return .pathErr }
        
        switch statusCode {
        case 200...210:
            return .success(decodedData.data ?? "data type error, failed")
        case 401:
            return .requestErr(false)
        case 404:
            return .requestErr(404)
        case 400, 402, 403, 405..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
