//
//  Mypage.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/16.
//

import UIKit
import SnapKit

class MypagePhotographerViewController: SnapfitUserInformationViewController {
    
    enum Text {
        static let settingSign = "icn_setting"
        static let editTitle = "수정하기"
    }
    
    // MARK: - UIComponents
    private let settingButton: UIButton = {
        let button: UIButton = UIButton()
        button.tintColor = .sfBlack100
        button.setImage(UIImage(named: Text.settingSign), for: .normal)
        return button
    }()
    private let editButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        button.titleLabel?.textColor = .sfWhite
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: Text.editTitle, attributes: attributes), for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 10)
        return button
    }()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setEditButtonAction()
        self.setMypageData()
        self.setPhotographerLayout()
        self.setMypageLayout()
        self.setSettingButton()
    }
    
    private func setMypageLayout() {
        self.addAtContentView(component: self.editButton)
        self.editButton.snp.makeConstraints{ make in
            make.top.equalTo(338)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    public func setMypageData() {
        getMyUserData { result in
            self.setNickname(text: result.nickname)
            self.setApproved(approveState: true)
            self.setInstagramText(text: result.instagramId)
            self.setMailText(text: result.email)
            self.setIntroduceText(text: result.info ?? "")
            self.setPossibleDateText(text: "아~ 힘드네요")
            self.setPriceText(text: result.cost ?? "")
            self.setProfileImage(profileImage: result.profileImageUrl)
            self.setBannerImage(bannerImage: result.thumbnailImageUrl)
            self.setGalleryAndReviewData(gallery: result.gallery, reviews: result.review, avgStars: result.averageStars ?? 0)
        }
    }
    
    private func setEditButtonAction() {
        lazy var viewController: MypagePhotographerEditingViewController = MypagePhotographerEditingViewController()
        // TODO: [Mypage] 마이페이지 수정 추가하기
//        viewController.setUserInformation(currentUser: currentUser)
        viewController.sendUpdateDelegate = self
        viewController.modalPresentationStyle = .fullScreen
        self.editButton.setAction {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func setSettingButton() {
        self.addAtContentView(component: self.settingButton)
        self.settingButton.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.trailing.equalTo(0)
            make.width.height.equalTo(48)
        }
        self.settingButton.setAction {
            lazy var settingViewController: SettingViewController = SettingViewController()
            settingViewController.modalPresentationStyle = .fullScreen
            self.present(settingViewController, animated: true)
        }
    }
}

extension MypagePhotographerViewController: SendUpdateDelegate {
    func sendUpdate(data: Any?) {
        // TODO: user data 업데이트 코드
        guard let newUserData = data as? User else { return }
//        self.currentUser.userName = newUserData.userName
        self.setNickname(text: newUserData.userName)
    }
}
