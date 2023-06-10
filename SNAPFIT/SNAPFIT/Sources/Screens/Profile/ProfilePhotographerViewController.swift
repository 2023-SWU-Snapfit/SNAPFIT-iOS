//
//  ProfilePhotographerViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/26.
//

import UIKit
import SnapKit

class ProfilePhotographerViewController: SnapfitUserInformationViewController {
    
    // MARK: - Properties
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backLikeMore)
        return view
    }()
    private let contactButton: UIButton = {
        let contactButton: UIButton = UIButton()
        contactButton.configuration = .filled()
        contactButton.setTitle("문의하기", for: .normal)
        contactButton.titleLabel?.font = .b14
        contactButton.titleLabel?.textColor = .sfWhite
        contactButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        contactButton.tintColor = .sfBlack100
        contactButton.makeRounded(cornerRadius: 10)
        return contactButton
    }()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPhotographerLayout()
        self.setContactButtonAction()
        self.setLayout()
    }
    
    // MARK: - Methods
    public func setUserInformation(currentUser: User) {
        self.setProfileImage(profileImage: currentUser.profileImage)
        self.setBannerImage(bannerImage: currentUser.backgroundImage)
        self.setBasicData(
            isApproved: true,
            nicknameText: currentUser.userName,
            instagramText: currentUser.instagramID
        )
        self.setAdditionalData(
            mailText: currentUser.emailAddress ?? "",
            introduceText: currentUser.introduceText ?? "",
            possibleDateText: currentUser.possibleDateText ?? "",
            priceText: currentUser.priceText ?? ""
        )
        self.setGalleryAndReviewData(galleryImages: currentUser.gallery, reviews: currentUser.reviews)
    }
    
    private func setAdditionalData(mailText: String,introduceText: String, possibleDateText: String, priceText: String) {
        self.setMailText(text: mailText)
        self.setIntroduceText(text: introduceText)
        self.setPossibleDateText(text: possibleDateText)
        self.setPriceText(text: priceText)
    }
    
    private func setContactButtonAction() {
        self.contactButton.setAction {
            lazy var suggestionViewController: ReservationSuggestionViewController = ReservationSuggestionViewController()
            suggestionViewController.modalTransitionStyle = .crossDissolve
            suggestionViewController.modalPresentationStyle = .overFullScreen
            self.present(suggestionViewController, animated: true)
        }
    }
    
    private func setLayout() {
        self.setNavigationView()
        self.addAtContentView(component: self.contactButton)
        self.contactButton.snp.makeConstraints{ make in
            make.top.equalTo(338)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    private func setNavigationView() {
        self.addAtContentView(component: navigationView)
        self.navigationView.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.left.right.equalToSuperview()
        }
        self.navigationView.backButton.setAction {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
