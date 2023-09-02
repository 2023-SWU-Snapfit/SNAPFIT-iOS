//
//  NetworkResult.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/10.
//

enum NetworkResult<ResponseData> {
    case success(ResponseData)
    case requestErr(ResponseData)
    case pathErr
    case serverErr
    case networkFail
}
