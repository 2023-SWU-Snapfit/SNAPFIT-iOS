//
//  UserInfo.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/10.
//

import Foundation

class UserInfo {
    static var shared = UserInfo()
    
    init() { }
    
    var userID: Int = -1
    var userPosition: String = ""
    var accessToken: String = ""
    var nickname: String = ""
    var deviceToken: String = "deviceToken"
}
