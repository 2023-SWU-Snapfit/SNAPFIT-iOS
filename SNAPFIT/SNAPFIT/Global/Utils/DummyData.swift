//
//  DummyData.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/10.
//

import Foundation
import UIKit

// MARK: - User[0]가 로그인한 계정. 즉, Mypage가 있는 자신의 계정으로 사용
// 그래서 favoriteUser 값은 0번 유저에만 추가해둠
var users: [User] = load("User.json")

struct User: Codable, Hashable {
    var isApproved: Bool = false
    var isPhotographer: Bool = false
    var instagramID: String
    var emailAddress: String?
    var indtroduceText: String?
    var possibleDateText: String?
    var priceText: String?
    var favoriteUser: [User]? = []
    
    private var profileImageName: String?
    var profileImage: UIImage?  {
        if let pn = profileImageName, profileImageName != "" {
            return UIImage(named: pn)
        }
        return nil
    }
    private var backgroundImageName: String?
    var backgroundImage: UIImage? {
        if let bn = backgroundImageName, backgroundImageName != "" {
            return UIImage(named: bn)
        }
        return nil
    }
    private var reviewText: [String]
    private var reviewScore: [Int]
    var reviews: [Review] {
        var rArray: [Review] = []
        for index in 0..<reviewScore.count {
            rArray.append(Review(score: reviewScore[index], contentText: reviewText[index]))
        }
        return rArray
    }
    private var reservationDate: [Date]
    private var reservationText: [String]
    var reservations: [Reservation] {
        var rArray: [Reservation] = []
        for index in 0..<reservationDate.count {
            rArray.append(Reservation(date: reservationDate[index], contentsText: reservationText[index]))
        }
        return rArray
    }
}

struct Review: Codable, Hashable {
    var score: Int = 0
    var contentText: String = "아주 좋아요! 맘에 듭니다~"
}

struct Reservation: Codable, Hashable {
    var date: Date
    var contentsText: String = ""
}
