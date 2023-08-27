//
//  MypageGeneralUserViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/04.
//

import UIKit
import SnapKit

class MypageGeneralUserViewController: SnapfitUserInformationViewController {
    
    let editButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: "수정하기", attributes: attributes), for: .normal)
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
        self.setMypageLayout()
        self.setApproved(approveState: true)
        self.setInstagramText(text: "bb098765")
        self.setMailText(text: "e-mail.emailLabel.com")
        self.setIntroduceText(text: """
    6월 말 우정 스냅 사진 촬영 작가 구하는 중!
    -- 경기 전북 출장 가능 --
    """
                             )
    }
    
    private func setMypageLayout() {
        self.addAtContentView(component: self.editButton)
        self.editButton.snp.makeConstraints{ make in
            make.top.equalTo(172)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    private func setEditButtonAction() {
        self.editButton.setAction {
            self.navigationController?.pushViewController(SnapfitUserInformationEditingViewController(), animated: true)
        }
    }
}
