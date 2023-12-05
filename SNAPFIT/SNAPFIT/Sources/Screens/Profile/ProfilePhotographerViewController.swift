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
    var currentUser: User!
    var targetID: Int = 0
    var likeState: Bool = false
    
    // MARK: - UIComponents
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backLikeMore)
        return view
    }()
    private let contactButton: UIButton = {
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
        self.setPhotographerLayout()
        self.setContactButtonAction()
        self.setLikeButtonAction()
        self.setMoreButtonAction()
        self.setLayout()
    }
    
    // MARK: - Methods
    public func setUserInformation(targetID: Int) {
        self.targetID = targetID
        getUserData(targetID: targetID) { result in
            self.setProfileImage(profileImage: result.profileImageUrl)
            self.setBannerImage(bannerImage: result.thumbnailImageUrl)
            self.setBasicData(
                isApproved: true,
                nicknameText: result.nickname,
                instagramText: result.instagramId
            )
            self.setAdditionalData(
                mailText: result.email,
                introduceText: result.info ?? "",
                possibleDateText: result.availableTime ?? "",
                priceText: result.cost ?? ""
            )
            if result.averageStars != 0.0 {
                ReviewService.shared.getReviewList(userId: targetID) { networkResult in
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
            self.setGalleryAndReviewData(gallery: result.gallery, reviews: result.review, avgStars: result.averageStars ?? 0.0)
            if result.isLike {
                self.likeState = true
                self.navigationView.likeButton.setImage(UIImage(named: SnapfitNavigationView.Text.likeButtonOnImageName), for: .normal)
                self.navigationView.likeButton.tintColor = .sfMainRed
            }
        }
    }
    
    private func setAdditionalData(mailText: String,introduceText: String, possibleDateText: String, priceText: String) {
        self.setMailText(text: mailText)
        self.setIntroduceText(text: introduceText)
        self.setPossibleDateText(text: possibleDateText)
        self.setPriceText(text: priceText)
    }
    
    private func setMoreButtonAction() {
        self.navigationView.moreButton.setAction {
            self.makeTwoAlertWithCancel(
                okTitle: "신고하기",
                secondOkTitle: "차단하기",
                okAction: { _ in
                    BlockService.shared.postBlock(targetId: self.targetID) { networkResult in
                        switch networkResult {
                        case .success:
                            print("Successfully blocked \(self.targetID)")
                        default:
                            print("Block ERROR")
                        }
                    }
                },
                secondOkAction: { _ in
                    ReportService.shared.postReport(targetId: self.targetID) { networkResult in
                        switch networkResult {
                        case .success:
                            print("Successfully reported \(self.targetID)")
                        default:
                            print("Block ERROR")
                        }
                    }
                })
        }
    }
    
    private func setLikeButtonAction() {
        self.navigationView.likeButton.setAction {
            LikeService.shared.postLike(targetId: self.targetID) { _ in }
            self.likeState.toggle()
            if self.likeState {
                DispatchQueue.main.async {
                    self.navigationView.likeButton.setImage(UIImage(named: SnapfitNavigationView.Text.likeButtonOnImageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
                }
                
            } else {
                DispatchQueue.main.async {
                    self.navigationView.likeButton.setImage(UIImage(named: SnapfitNavigationView.Text.likeButtonImageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
                    
                }
            }
        }
    }
    
    private func setContactButtonAction() {
        self.contactButton.setAction {
            lazy var suggestionViewController: ReservationSuggestionViewController = ReservationSuggestionViewController()
            suggestionViewController.setUserData(userID: self.targetID)
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
