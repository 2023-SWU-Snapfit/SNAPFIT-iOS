//
//  NetworkResult.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/10.
//

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
