//
//  MypageGeneralUserViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/04.
//

import UIKit
import SnapKit

class MypageGeneralUserViewController: SnapfitUserInformationViewController {
    
    enum Text {
        static let settingSign = "icn_setting"
        static let editTitle = "수정하기"
    }
    
    // MARK: - UI Components
    var currentUser: User = User(
        userName: "bb098765",
        isApproved: true,
        isPhotographer: false,
        instagramID: "",
        emailAddress: "e-mail.emailLabel.com",
        introduceText: """
    6월 말 우정 스냅 사진 촬영 작가 구하는 중!
    -- 경기 전북 출장 가능 --
    """,
        possibleDateText: "",
        priceText: """
    가격 문의 바로 주세요
    """)
    
    let profileImage: UIImage = UIImage(named: "sampleImage23")!
    let galleryImages: [UIImage] = [UIImage(named: "sampleImage23")!, UIImage(named: "sampleImage26")!, UIImage(named: "sampleImage28")!, UIImage(named: "sampleImage29")!]
    let reviewData: [Review] = [
        Review(userName: "오인하", imageName: "sampleImage27", score: 4, contentText: "개인 프로필로 하나 찍었어요~"),
        Review(userName: "한도윤", imageName: "sampleImage25", score: 5, contentText: "커플 스냅 사진 분위기 진짜 잘 맞아서 좋아요"),
        Review(userName: "류태현", imageName: "sampleImage24", score: 3, contentText: "자연스러운 분위기 선호해서 마음에 듭니다"),
        Review(userName: "민주영", imageName: "sampleImage28", score: 5, contentText: "분위기 있게 찍고 싶었는데 잘 나왔네요 ㅎㅎ")]
    
    // MARK: - UI Components
    private let settingButton: UIButton = {
        let button: UIButton = UIButton()
        button.tintColor = .sfBlack100
        button.setImage(UIImage(named: Text.settingSign), for: .normal)
        return button
    }()
    let editButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: Text.editTitle, attributes: attributes), for: .normal)
        button.titleLabel?.textColor = .sfWhite
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 10)
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setEditButtonAction()
        
        self.setGeneralUserLayout()
        self.setMypageData()
        self.setMypageLayout()
        self.setSettingButton()
    }
    
    private func setMypageLayout() {
        self.addAtContentView(component: self.editButton)
        self.editButton.snp.makeConstraints{ make in
            make.top.equalTo(172)
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
            self.setPossibleDateText(text: "")
            self.setPriceText(text: result.cost ?? "")
            self.setProfileImage(profileImage: result.profileImageUrl)
            self.setBannerImage(bannerImage: result.thumbnailImageUrl)
            if result.averageStars != 0.0 {
                ReviewService.shared.getReviewList(userId: UserInfo.shared.userID) { networkResult in
                    switch networkResult {
                    case .success(let responseData):
                        if let result = responseData as? ReviewListResponseDTO {
                            self.setGptData(gptReview: result.gptReview)
                        }
                    default:
                        print("DEFAULT")
                    }
                }
            }
            self.setGalleryAndReviewData(gallery: result.gallery, reviews: result.review, avgStars: result.averageStars ?? 0)
        }
    }
    
    private func setEditButtonAction() {
        self.editButton.setAction {
            lazy var viewController: MypageGeneralUserEditingViewController = MypageGeneralUserEditingViewController()
            viewController.setUserInformation(currentUser: self.currentUser)
            viewController.sendUpdateDelegate = self
            viewController.modalPresentationStyle = .fullScreen
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

extension MypageGeneralUserViewController: SendUpdateDelegate {
    func sendUpdate(data: Any?) {
        // TODO: user data 업데이트 코드
        guard let newUserData = data as? User else { return }
        self.currentUser.userName = newUserData.userName
        self.setNickname(text: newUserData.userName)
    }
}
