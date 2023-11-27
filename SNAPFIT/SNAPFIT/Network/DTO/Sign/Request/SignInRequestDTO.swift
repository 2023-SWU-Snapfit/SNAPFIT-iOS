//
//  SignInRequestDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/15/23.
//

import Foundation

struct SignInRequestDTO: Codable {
    let email: String
    let password: String
    let deviceToken: String
}
