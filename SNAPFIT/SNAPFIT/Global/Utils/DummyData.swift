//
//  DummyData.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/10.
//

import Foundation
import UIKit

// MARK: - Mypage는 이미 정보 다 입력해둔 상시 페이지가 나오니까 보이는데 필요한 정보만 사용.
//필수요소: isApproved, isPhotographer, galleryImageText, reviewText, reviewScore, reviewImageText
//reviewText, reviewScore, reviewImageText 이거 세개는 갯수 맞추기
//backgroundImage는 profileView에서 bannerImage와 동일한 역할
var users: [User] = load("Users.json")

struct User: Codable, Hashable {
    var userName: String
    var isApproved: Bool = false
    var isPhotographer: Bool = false
    var instagramID: String
    var emailAddress: String?
    var introduceText: String?
    var possibleDateText: String?
    var priceText: String?
//    var favoriteUser: [User]? = []
    
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
    
    private var galleryImageText: [String]
    var gallery: [UIImage] {
        var gArray: [UIImage] = []
        for index in 0..<galleryImageText.count {
            gArray.append(UIImage(named: galleryImageText[index])!)
        }
        return gArray
    }
    
    private var reviewText: [String]
    private var reviewScore: [Int]
    private var reviewImageText: [String] = []
    var reviews: [Review] {
        var rArray: [Review] = []
        for index in 0..<reviewScore.count {
            rArray.append(Review(imageName: reviewImageText[index], score: reviewScore[index], contentText: reviewText[index]))
        }
        return rArray
    }
//    private var reservationDate: [Date]
//    private var reservationText: [String]
//    var reservations: [Reservation] {
//        var rArray: [Reservation] = []
//        for index in 0..<reservationDate.count {
//            rArray.append(Reservation(date: reservationDate[index], contentsText: reservationText[index]))
//        }
//        return rArray
//    }
}

struct Review: Codable, Hashable {
    var imageName: String
    var images: UIImage? {
        if imageName != "" {
            return UIImage(named: imageName)
        }
        return nil
    }
    var score: Int = 0
    var contentText: String = "아주 좋아요! 맘에 듭니다~"
}

struct Reservation: Codable, Hashable {
    var date: Date
    var contentsText: String = ""
}
