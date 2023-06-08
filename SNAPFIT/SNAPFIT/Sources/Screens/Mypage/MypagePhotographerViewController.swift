//
//  Mypage.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/16.
//

import UIKit
import SnapKit

class MypagePhotographerViewController: SnapfitUserInformationViewController {
    
    private let editButton: UIButton = {
        let contactButton: UIButton = UIButton()
        contactButton.configuration = .filled()
        contactButton.setTitle("수정하기", for: .normal)
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
        self.setNickname(text: "닉네임 보여주기")
        self.setApproved(approveState: true)
        self.setInstagramText(text: "snap-iOS")
        self.setMailText(text: "snap-iOS.google.com")
        self.setIntroduceText(text: """
    연인/우정 스냅 경력 3년
    서울/경기 스냅 사진 전문
    """
        )
        self.setPossibleDateText(text: """
    *** 6월은 마지막 주 주말만 가능! ***
    
    촬영은 주말만 가능. 촬영 후 보정본 받는 건 촬영 다음 주 목요일까지 가능합니다.
    일찍 되면 일찍 되는대로 보내드려요.
    """
        )
        self.setPriceText(text: """
    기본 필름 5장: 100000원
        - 필름 원본 제공
        - 마음에 드는 사진 선택 후 보정 5장 제공
    기본 디지털 5장: 80000원
        - 디지털 사진 원본 10장 제공
        - 10장 중 보정본 5장 제공
    
    사진 추가 제공은 추가금 있음
    보정본 장 당 5000원
    원본 장 당 2000원
    
    서울, 경기 외 지역 출장 시 출장비 문의 후 결정
    """
        )
        self.setPhotographerLayout()
        self.setMypageLayout()
    }
    
    private func setMypageLayout() {
        self.addAtContentView(component: self.editButton)
        self.editButton.snp.makeConstraints{ make in
            make.top.equalTo(338)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    public func setMypageData() {
        
    }
}
