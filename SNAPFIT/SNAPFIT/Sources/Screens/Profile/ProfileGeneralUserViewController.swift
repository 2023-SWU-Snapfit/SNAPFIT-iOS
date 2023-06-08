//
//  ProfileGeneralUserViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/04.
//

import UIKit
import SnapKit

class ProfileGeneralUserViewController: SnapfitUserInformationViewController {
    
    // MARK: - Properties
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backLikeMore)
        return view
    }()
    let contactButton: UIButton = {
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
        self.setGeneralUserLayout()
        self.setLayout()
    }
    
    // MARK: - Methods
    public func setBasicData(isApproved: Bool, nicknameText: String, instagramText: String) {
        self.setApproved(approveState: isApproved)
        self.setNickname(text: nicknameText)
        self.setInstagramText(text: instagramText)
    }

    public func setAdditionalData(mailText: String,introduceText: String) {
        self.setMailText(text: mailText)
        self.setIntroduceText(text: introduceText)
    }
    
    private func setLayout() {
        self.view.addSubviews([navigationView])
        self.setNavigationView()
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.addAtContentView(component: self.contactButton)
        self.contactButton.snp.makeConstraints{ make in
            make.top.equalTo(172)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    private func setNavigationView() {
        self.navigationView.backButton.setAction {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
