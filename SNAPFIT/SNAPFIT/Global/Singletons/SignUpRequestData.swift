//
//  SignUpRequestData.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/27/23.
//

import Foundation
import UIKit.UIImage

class SignUpRequestData {
    static var shared = SignUpRequestData()
    
    init() { }
    
    var profileImageUrl: UIImage = UIImage()
    var email: String = ""
    var nickname: String = ""
    var password: String = ""
    var instagramId: String = ""
    var cost: String = ""
    var position: String = ""
    var contactUrl: String = ""
    var interest: [Int] = []
    
    func dtoData() -> SignUpRequestDTO {
        return .init(profileImageUrl: self.profileImageUrl, email: self.email, nickname: self.nickname, password: self.password, instagramId: self.instagramId, cost: self.cost, position: self.position, contactUrl: self.contactUrl, interest: self.interest)
    }
}
