//
//  Message.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/14.
//

enum Message {
    case networkError
}

extension Message {
    
    var text: String {
        switch self {
        case .networkError:
            return
"""
네트워크 오류로 인해 연결에 실패하였습니다.
잠시 후에 다시 시도해 주세요.
"""
        }
    }
}
