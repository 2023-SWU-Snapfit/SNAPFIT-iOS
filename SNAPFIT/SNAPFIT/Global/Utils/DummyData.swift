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
//자신의 ID 133으로 가정하고 작성
var users: [User] = load("Users.json")
var favorites: [User] = users
var reservationData: [Reservation] = load("Reservations.json")

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
            rArray.append(Review(userName: "\(users[index].userName)", imageName: reviewImageText[index], score: reviewScore[index], contentText: reviewText[index]))
        }
        return rArray
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.isApproved = try container.decode(Bool.self, forKey: .isApproved)
        self.isPhotographer = try container.decode(Bool.self, forKey: .isPhotographer)
        self.instagramID = try container.decode(String.self, forKey: .instagramID)
        self.emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
        self.introduceText = try container.decodeIfPresent(String.self, forKey: .introduceText)
        self.possibleDateText = try container.decodeIfPresent(String.self, forKey: .possibleDateText)
        self.priceText = try container.decodeIfPresent(String.self, forKey: .priceText)
        self.profileImageName = try container.decodeIfPresent(String.self, forKey: .profileImageName)
        self.backgroundImageName = try container.decodeIfPresent(String.self, forKey: .backgroundImageName)
        self.galleryImageText = try container.decode([String].self, forKey: .galleryImageText)
        self.reviewText = try container.decode([String].self, forKey: .reviewText)
        self.reviewScore = try container.decode([Int].self, forKey: .reviewScore)
        self.reviewImageText = try container.decode([String].self, forKey: .reviewImageText)
    }
    
    init(userName: String, isApproved: Bool, isPhotographer: Bool, instagramID: String, emailAddress: String?, introduceText: String?, possibleDateText: String?, priceText: String?) {
        self.userName = userName
        self.isApproved = isApproved
        self.isPhotographer = isPhotographer
        self.instagramID = instagramID
        self.emailAddress = emailAddress
        self.introduceText = introduceText
        self.possibleDateText = possibleDateText
        self.priceText = priceText
        self.profileImageName = "sampleImage23"
        self.backgroundImageName = "sampleImage25"
        self.galleryImageText = ["sampleImage23", "sampleImage26", "sampleImage28", "sampleImage29"]
        self.reviewText = ["dd", "bb", "Good!"]
        self.reviewScore = [5,3,4]
        self.reviewImageText = ["", "sampleImage23", "sampleImage29"]
    }
    
    
//    private var reservationDate: [Date]
//    private var reservationText: [String]
//    var reservationUsers: [Reservation] {
//        var rArray: [Reservation] = []
//        for index in 0..<reservationDate.count {
//            rArray.append(Reservation(date: reservationDate[index], contentsText: reservationText[index]))
//        }
//        return rArray
//    }
}

struct Review: Codable, Hashable {
    var userName: String
    var imageName: String
    var image: UIImage? {
        if imageName != "" {
            return UIImage(named: imageName)
        }
        return nil
    }
    var score: Int = 0
    var contentText: String = "아주 좋아요! 맘에 듭니다~"
}

struct Reservation: Codable, Hashable {
    var senderID: Int = 133
    var recieverID: Int
    var dateText: String
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일 a hh시 mm분"
        return dateFormatter.date(from: dateText) ?? Date()
    }
    var contentsText: String = ""
    var isFixed: Bool = false
    var isFinished: Bool = false
    var lastUpdateText: String
    var lastUpdate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd HH:mm"
        return dateFormatter.date(from: lastUpdateText) ?? Date()
    }
}
