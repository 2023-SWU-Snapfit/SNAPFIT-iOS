//
//  ProfileGeneralUserViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/04.
//

import UIKit
import SnapKit

class ProfileGeneralUserViewController: SnapfitUserInformationViewController {
    
    var currentUser: User!
    
    // MARK: - Properties
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backLikeMore)
        return view
    }()
    let contactButton: UIButton = {
        let contactButton: UIButton = UIButton()
        contactButton.configuration = .filled()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        contactButton.setAttributedTitle(NSAttributedString(string: "문의하기", attributes: attributes), for: .normal)
        contactButton.titleLabel?.textColor = .sfWhite
        contactButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        contactButton.tintColor = .sfBlack100
        contactButton.makeRounded(cornerRadius: 10)
        return contactButton
    }()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGeneralUserLayout()
        self.setContactButtonAction()
        self.setMoreButtonAction()
        self.setLayout()
    }
    
    // MARK: - Methods
    public func setUserInformation(currentUser: User) {
        self.currentUser = currentUser
        self.setProfileImage(profileImage: currentUser.profileImage)
        self.setBasicData(
            isApproved: true,
            nicknameText: currentUser.userName,
            instagramText: currentUser.instagramID
        )
        self.setAdditionalData(
            mailText: currentUser.emailAddress ?? "",
            introduceText: currentUser.introduceText ?? ""
        )
        self.setGalleryAndReviewData(galleryImages: currentUser.gallery, reviews: currentUser.reviews)
    }
    
    private func setAdditionalData(mailText: String,introduceText: String) {
        self.setMailText(text: mailText)
        self.setIntroduceText(text: introduceText)
    }
    
    private func setContactButtonAction() {
        self.contactButton.setAction {
            lazy var suggestionViewController: ReservationSuggestionViewController = ReservationSuggestionViewController()
            suggestionViewController.setUserData(user: self.currentUser)
            suggestionViewController.modalTransitionStyle = .crossDissolve
            suggestionViewController.modalPresentationStyle = .overFullScreen
            self.present(suggestionViewController, animated: true)
        }
    }
    
    private func setMoreButtonAction() {
        self.navigationView.moreButton.setAction {
            self.makeTwoAlertWithCancel(
                okTitle: "신고하기",
                secondOkTitle: "차단하기",
                okAction: { _ in
                    // TODO: 신고 action 추가
                    print("신고")
                },
                secondOkAction: { _ in
                    // TODO: 차단 action 추가
                    print("차단")
                })
        }
    }
    
    private func setLayout() {
        self.setNavigationView()
        self.addAtContentView(component: self.contactButton)
        self.contactButton.snp.makeConstraints{ make in
            make.top.equalTo(172)
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
