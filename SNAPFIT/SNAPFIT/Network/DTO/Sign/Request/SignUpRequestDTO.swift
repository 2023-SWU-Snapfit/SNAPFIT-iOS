//
//  SignUpRequestDTO.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/27/23.
//

import Foundation
import UIKit.UIImage

struct SignUpRequestDTO {
    let profileImageUrl: UIImage
    let email: String
    let nickname: String
    let password: String
    let instagramId: String
    let cost: String
    let position: String
    let contactUrl: String
    let interest: [Int]
}
