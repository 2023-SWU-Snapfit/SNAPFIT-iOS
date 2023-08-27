//
//  MypagePhotographerEditingViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/08/26.
//

import UIKit
import SnapKit

class MypagePhotographerEditingViewController: SnapfitUserInformationEditingViewController {
    
    // MARK: - Properties
    var currentUser: User!
    var sendUpdateDelegate: SendUpdateDelegate?
    
    // MARK: - UIComponents
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backSave)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPhotographerLayout()
        self.setEditingActions()
        self.setSaveButtonAction()
        self.setLayout()
    }
    
    // MARK: - Methods
    public func setUserInformation(currentUser: User) {
        self.currentUser = currentUser
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
    }
    
    private func setAdditionalData(mailText: String,introduceText: String, possibleDateText: String, priceText: String) {
        self.setMailText(text: mailText)
        self.setIntroduceText(text: introduceText)
        self.setPossibleDateText(text: possibleDateText)
        self.setPriceText(text: priceText)
    }
    
    private func setSaveButtonAction() {
        self.navigationView.moreButton.setAction {
            self.currentUser = self.getNewUserInformation()
            self.sendUpdateDelegate?.sendUpdate(data: self.currentUser)
        }
    }
    
    private func setLayout() {
        self.setNavigationView()
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
