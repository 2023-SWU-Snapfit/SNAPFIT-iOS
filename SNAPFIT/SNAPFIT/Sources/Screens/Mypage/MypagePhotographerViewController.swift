//
//  Mypage.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/16.
//

import UIKit
import SnapKit

class MypagePhotographerViewController: BaseViewController {
    // MARK: - Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bannerImageView = UIImageView()
    let profileImageView = UIImageView()
    let phoneApprovedLabel = UILabel()
    let nicknameLabel = UILabel()
    let mailLabel = UILabel()
    let introduceTextView = TextboxView()
    let galleryCarouselViewController = GalleryCollectionlViewController()
    let reviewCarouselViewController = ReviewCollectionlViewController()
    let possibleDateTitleLabel = UILabel()
    let possibleDateTextView = TextboxView()
    let priceTitleLabel = UILabel()
    let priceTextView = TextboxView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Initialization
        scrollView.backgroundColor = .sfGrayWhite
        scrollView.showsVerticalScrollIndicator = false
        
        bannerImageView.setImageColor(color: .sfBlack40)
        self.bannerImageView.backgroundColor = .sfBlack20
        
        profileImageView.setImageColor(color: .sfBlack40)
        self.profileImageView.backgroundColor = .sfBlack40
        self.profileImageView.layer.cornerRadius = 50
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.clear.cgColor
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        
        self.phoneApprovedLabel.text = "휴대폰 인증 완료"
        self.phoneApprovedLabel.font = .m12
        
        self.nicknameLabel.text = "열글자까지가능한이름"
        self.nicknameLabel.font = .m24
        
        self.mailLabel.text = "e-mailLabel.emailLabel.com"
        self.mailLabel.font = .m12
        
        self.introduceTextView.setBasicTextbox()
        self.introduceTextView.text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    
    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    일부러 길게 적어봤다. 과연 어떻게 보일지 궁금하기도 하고... 한국어 대응은 잘 되는군! 일단 멀티라인 스트링이 당연히 필요할테니 길게... 사용해봤다
    그리고 이렇게 길게 썼는데도 스크롤 멀쩡히 작동하니 만족!
    """
        
        self.possibleDateTitleLabel.text = "예약 가능 날짜"
        self.possibleDateTitleLabel.font = .b18
        
        self.possibleDateTextView.setBasicTextbox()
        self.possibleDateTextView.text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    AA - $200
    AB - $60
    """
        self.priceTitleLabel.text = "촬영 비용"
        self.priceTitleLabel.font = .b18
        
        self.priceTextView.setBasicTextbox()
        self.priceTextView.text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    """
        
        // MARK: - UI
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints{ make in
            make.edges.width.equalToSuperview()
        }
        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.contentView.addSubview(self.bannerImageView)
        self.bannerImageView.snp.makeConstraints{ make in
            make.top.width.equalToSuperview()
            make.height.equalTo(320)
        }
        self.contentView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(270)
            make.left.equalTo(20)
            make.height.width.equalTo(100)
        }
        self.contentView.addSubview(self.phoneApprovedLabel)
        self.phoneApprovedLabel.snp.makeConstraints{ make in
            make.top.equalTo(380)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints{ make in
            make.top.equalTo(408)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.mailLabel)
        self.mailLabel.snp.makeConstraints{ make in
            make.top.equalTo(451)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.introduceTextView)
        self.introduceTextView.snp.makeConstraints{ make in
            make.top.equalTo(487)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.galleryCarouselViewController.view)
        self.galleryCarouselViewController.view.snp.makeConstraints{ make in
            make.top.equalTo(introduceTextView.snp.bottom).offset(24)
            make.left.right.width.equalToSuperview()
            make.height.equalTo(175)
        }
        self.contentView.addSubview(self.reviewCarouselViewController.view)
        self.reviewCarouselViewController.view.snp.makeConstraints{ make in
            make.top.equalTo(galleryCarouselViewController.view.snp.bottom).offset(24)
            make.left.right.width.equalToSuperview()
            make.height.equalTo(220)
        }
        self.contentView.addSubview(self.possibleDateTitleLabel)
        self.possibleDateTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(reviewCarouselViewController.view.snp.bottom).offset(24)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.possibleDateTextView)
        self.possibleDateTextView.snp.makeConstraints{ make in
            make.top.equalTo(possibleDateTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.priceTitleLabel)
        self.priceTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(possibleDateTextView.snp.bottom).offset(24)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.priceTextView)
        self.priceTextView.snp.makeConstraints{ make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(20)
            make.width.bottom.equalToSuperview().inset(20)
        }
    }
}
