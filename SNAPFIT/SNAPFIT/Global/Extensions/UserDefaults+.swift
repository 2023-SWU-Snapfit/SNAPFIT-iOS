//
//  UserDefaults+.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/14.
//

import Foundation

extension UserDefaults {
    
    /// UserDefaults key value가 많아지면 관리하기 어려워지므로 enum 'Keys'로 묶어 관리합니다.
    enum Keys {
        static var userID = "userID"
        static var email = "email"
        static var password = "password"
        static var FCMTokenForDevice = "FCMTokenForDevice"
    }
}
