//
//  SnapfitUserInformationViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/26.
//

import UIKit
import SnapKit

class SnapfitUserInformationViewController: BaseViewController {
    
    enum Text {
        static let photographerSign = "icn_camera"
        static let photographer = "사진작가"
        static let phoneApprovedSign = "checkmark.square.fill"
        static let phoneApproved = "휴대폰 인증 완료"
        static let nickname = "열글자까지가능한이름"
        static let instagramSign = "icn_instagram"
        static let mailSign = "icn_mail"
        static let possibleDate = "예약 가능 날짜"
        static let price = "촬영 비용"
    }
    
    // MARK: - Properties
    private let isPhotographer: Bool = false
    private let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .sfGrayWhite
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView: UIView = UIView()
    private let bannerImageView: UIImageView = {
        let bannerImageView: UIImageView = UIImageView()
        bannerImageView.setImageColor(color: .sfBlack40)
        bannerImageView.backgroundColor = .sfBlack20
        return bannerImageView
        
    }()
    private let profileImageView: UIImageView = {
        let profileImageView: UIImageView = UIImageView()
        return profileImageView
    }()
    private let photographerSignImageView: UIImageView = {
        let photographerSignImageView: UIImageView = UIImageView()
        photographerSignImageView.image = UIImage(named: Text.photographerSign)
        photographerSignImageView.contentMode = .scaleAspectFit
        photographerSignImageView.tintColor = .sfMainRed
        return photographerSignImageView
    }()
    private let photographerLabel: UILabel = {
        let photographerLabel: UILabel = UILabel()
        photographerLabel.text = Text.photographer
        photographerLabel.font = .m12
        return photographerLabel
    }()
    private let phoneApprovedImageView: UIImageView = {
        let phoneApprovedImageView: UIImageView = UIImageView()
        phoneApprovedImageView.image = UIImage(systemName: Text.phoneApprovedSign)
        phoneApprovedImageView.contentMode = .scaleAspectFit
        phoneApprovedImageView.tintColor = .sfMainRed
        return phoneApprovedImageView
    }()
    private let phoneApprovedLabel: UILabel = {
        let phoneApprovedLabel: UILabel = UILabel()
        phoneApprovedLabel.text = Text.phoneApproved
        phoneApprovedLabel.font = .m12
        return phoneApprovedLabel
    }()
    private let nicknameLabel: UILabel = {
        let nicknameLabel: UILabel = UILabel()
        nicknameLabel.text = Text.nickname
        nicknameLabel.font = .m24
        return nicknameLabel

    }()
    private let instagramSignImageView: UIImageView = {
        let instagramSignImageView: UIImageView = UIImageView()
        instagramSignImageView.image = UIImage(named: Text.instagramSign)
        instagramSignImageView.contentMode = .scaleAspectFit
        instagramSignImageView.tintColor = .sfMainRed
        return instagramSignImageView
    }()
    private let instagramLabel: UILabel = {
        let instagramLabel: UILabel = UILabel()
        instagramLabel.font = .m12
        return instagramLabel
    }()
    private let mailSignImageView: UIImageView = {
        let mailSignImageView: UIImageView = UIImageView()
        mailSignImageView.image = UIImage(named: Text.mailSign)
        mailSignImageView.contentMode = .scaleAspectFit
        mailSignImageView.tintColor = .sfMainRed
        return mailSignImageView
    }()
    private let mailLabel: UILabel = {
        let mailLabel: UILabel = UILabel()
        mailLabel.font = .m12
        return mailLabel
    }()
    private let introduceTextView: SnapfitTextView = {
        let introduceTextView: SnapfitTextView = SnapfitTextView(isEditable: false)
        return introduceTextView
    }()
    private let galleryCarouselViewController: UserGalleryCollectionViewController = UserGalleryCollectionViewController()
    private let reviewCarouselViewController: ReviewCollectionViewController = ReviewCollectionViewController()
    private let possibleDateTitleLabel: UILabel = {
        let possibleDateTitleLabel: UILabel = UILabel()
        possibleDateTitleLabel.text = Text.possibleDate
        possibleDateTitleLabel.font = .b18
        return possibleDateTitleLabel
    }()
    private let possibleDateTextView: SnapfitTextView = {
        let possibleDateTextView: SnapfitTextView = SnapfitTextView(isEditable: false)
        return possibleDateTextView
    }()
    private let priceTitleLabel: UILabel = {
        let priceTitleLabel: UILabel = UILabel()
        priceTitleLabel.text = Text.price
        priceTitleLabel.font = .b18
        return priceTitleLabel
    }()
    private let priceTextView: SnapfitTextView = {
        let priceTextView: SnapfitTextView = SnapfitTextView(isEditable: false)
        return priceTextView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setProfileImageViewStyle()
    }
    
    // MARK: - Methods
    public func addAtContentView(component: UIView) {
        self.contentView.addSubview(component)
    }
    
    public func setInstagramText(text: String) {
        self.instagramLabel.text = text
    }
    
    public func setMailText(text: String) {
        self.mailLabel.text = text
    }

    public func setIntroduceText(text: String) {
        self.introduceTextView.setText(text: text)
    }
    
    public func setPossibleDateText(text: String) {
        if text == "" {
            self.possibleDateTitleLabel.isHidden = true
            self.possibleDateTitleLabel.snp.makeConstraints{ make in
                make.top.equalTo(possibleDateTitleLabel.snp.bottom)
            }
        } else {
            self.possibleDateTitleLabel.isHidden = false
            self.possibleDateTextView.snp.makeConstraints{ make in
                make.top.equalTo(possibleDateTitleLabel.snp.bottom).offset(16)
            }
        }
        self.possibleDateTextView.setText(text: text)
    }
    
    public func setPriceText(text: String) {
        if text == "" {
            self.priceTitleLabel.isHidden = true
            self.priceTextView.snp.makeConstraints{ make in
                make.top.equalTo(priceTitleLabel.snp.bottom)
            }
        } else {
            self.priceTitleLabel.isHidden = false
            self.priceTextView.snp.makeConstraints{ make in
                make.top.equalTo(priceTitleLabel.snp.bottom).offset(16)
            }
            
        }
        self.priceTextView.setText(text: text)
    }
    
}

extension SnapfitUserInformationViewController {
    
    // MARK: - LayoutMethods
    private func setProfileImageViewStyle() {
        self.profileImageView.setImageColor(color: .sfBlack40)
        self.profileImageView.backgroundColor = .sfBlack40
        self.profileImageView.layer.cornerRadius = 50
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.clear.cgColor
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
    }
    
    private func setInstagramLayout() {
        let topMargin = isPhotographer ? 450 : 285
        self.contentView.addSubview(self.instagramSignImageView)
        self.instagramSignImageView.snp.makeConstraints{ make in
            make.top.equalTo(topMargin)
            make.left.equalTo(20)
            make.width.height.equalTo(20)
        }
        self.contentView.addSubview(self.instagramLabel)
        self.instagramLabel.snp.makeConstraints{ make in
            make.top.equalTo(topMargin)
            make.left.equalTo(self.instagramSignImageView.snp.right).offset(4)
            make.height.equalTo(20)
        }
    }
    
    private func setMailLayout() {
        let topMargin = isPhotographer ? 450: 285
        self.contentView.addSubview(self.mailSignImageView)
        self.mailSignImageView.snp.makeConstraints{ make in
            make.top.equalTo(topMargin)
            make.left.equalTo(self.instagramLabel.snp.right).offset(4)
            make.width.height.equalTo(20)
        }
        self.contentView.addSubview(self.mailLabel)
        self.mailLabel.snp.makeConstraints{ make in
            make.top.equalTo(topMargin)
            make.left.equalTo(self.mailSignImageView.snp.right).offset(4)
            make.height.equalTo(20)
        }
    }
    
    private func setPhoneApproved() {
        if isPhotographer {
            self.contentView.addSubview(self.phoneApprovedImageView)
            self.phoneApprovedImageView.snp.makeConstraints{ make in
                make.top.equalTo(380)
                make.left.equalTo(self.photographerLabel.snp.right).offset(4)
                make.width.height.equalTo(20)
            }
            self.contentView.addSubview(self.phoneApprovedLabel)
            self.phoneApprovedLabel.snp.makeConstraints{ make in
                make.top.equalTo(380)
                make.left.equalTo(self.phoneApprovedImageView.snp.right).offset(4)
                make.height.equalTo(20)
            }
        } else {
            self.contentView.addSubview(self.phoneApprovedImageView)
            self.phoneApprovedImageView.snp.makeConstraints{ make in
                make.top.equalTo(214)
                make.left.equalTo(20)
                make.width.height.equalTo(20)
            }
            self.contentView.addSubview(self.phoneApprovedLabel)
            self.phoneApprovedLabel.snp.makeConstraints{ make in
                make.top.equalTo(214)
                make.left.equalTo(self.phoneApprovedImageView.snp.right).offset(4)
                make.height.equalTo(20)
            }
        }
    }
    
    private func setGalleryAndReviewLayout() {
        
    }
    
    public func setPhotographerLayout() {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints{ make in
            make.bottom.left.right.width.equalToSuperview()
            make.top.equalTo(-48)
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
        self.contentView.addSubview(self.photographerSignImageView)
        self.photographerSignImageView.snp.makeConstraints{ make in
            make.top.equalTo(380)
            make.left.equalTo(20)
            make.width.height.equalTo(20)
        }
        self.contentView.addSubview(self.photographerLabel)
        self.photographerLabel.snp.makeConstraints{ make in
            make.top.equalTo(380)
            make.left.equalTo(self.photographerSignImageView.snp.right).offset(4)
            make.height.equalTo(20)
        }
        self.setPhoneApproved()
        self.contentView.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints{ make in
            make.top.equalTo(408)
            make.left.equalTo(20)
        }
        self.setInstagramLayout()
        self.setMailLayout()
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
    
    public func setGeneralUserLayout() {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints{ make in
            make.bottom.left.right.width.equalToSuperview()
            make.top.equalTo(-48)
        }
        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.contentView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(104)
            make.left.equalTo(20)
            make.height.width.equalTo(100)
        }
        self.setPhoneApproved()
        self.contentView.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints{ make in
            make.top.equalTo(242)
            make.left.equalTo(20)
        }
        self.setInstagramLayout()
        self.setMailLayout()
        self.contentView.addSubview(self.introduceTextView)
        self.introduceTextView.snp.makeConstraints{ make in
            make.top.equalTo(320)
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
            make.left.right.width.bottom.equalToSuperview()
            make.height.equalTo(220)
        }
    }
}
