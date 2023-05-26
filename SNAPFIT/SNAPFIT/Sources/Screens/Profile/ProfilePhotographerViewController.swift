//
//  ProfilePhotographerViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/26.
//

import UIKit
import SnapKit

class ProfilePhotographerViewController: SnapfitUserInformationViewController {
    
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
        self.setPhotographerLayout()
        self.setMypageLayout()
        self.setMailText(text: "e-mail.emailLabel.com")
        self.setIntroduceText(text: """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

    한국어 대응 가능
    """
                             )
        self.setPossibleDateText(text: """
    멀티라인 스트링 입력 가능
    AA - $200
    AB - $60
    """
                                 )
        self.setPriceText(text: """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    """
                          )
    }
    
    
    private func setMypageLayout() {
        self.addAtContentView(component: self.contactButton)
        self.contactButton.snp.makeConstraints{ make in
            make.top.equalTo(338)
            make.right.equalToSuperview().inset(20)
        }
    }
}
