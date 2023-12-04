//
//  TopUsers.swift
//  SNAPFIT
//
//  Created by Jungbin on 12/4/23.
//

import Foundation

class TopUsers {
    static var shared = TopUsers()
    
    init() { }
    
    var data: [GetTopUsersResponseDTO] = []
}
