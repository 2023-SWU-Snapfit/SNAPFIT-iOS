//
//  Mypage.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/16.
//

import UIKit
import SnapKit

class MypagePhotographerViewController: BaseViewController {
    // MARK: - Properties
    let scrollView = UIScrollView()
    let bannerImageView = UIImageView()
    let profileImageView = UIImageView()
    let phoneApproved = UILabel()
    let nickname = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Initialization
        scrollView.backgroundColor = .systemBackground
        
        bannerImageView.setImageColor(color: .sfBlack40)
        self.bannerImageView.backgroundColor = .sfBlack20
        
        profileImageView.setImageColor(color: .sfBlack40)
        self.profileImageView.backgroundColor = .sfBlack40
        self.profileImageView.layer.cornerRadius = 50
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.clear.cgColor
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        
        self.phoneApproved.text = "휴대폰 인증 완료"
        
        self.nickname.text = "열글자까지가능한이름"
        self.nickname.font = .systemFont(ofSize: 24)
        
        // MARK: - UI
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        self.scrollView.addSubview(self.bannerImageView)
        self.bannerImageView.snp.makeConstraints{ make in
            make.top.width.equalToSuperview()
            make.height.equalTo(320)
        }
        self.scrollView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(270)
            make.left.equalTo(20)
            make.height.width.equalTo(100)
        }
        self.scrollView.addSubview(self.phoneApproved)
        self.phoneApproved.snp.makeConstraints{ make in
            make.top.equalTo(380)
            make.left.equalTo(20)
        }
        self.scrollView.addSubview(self.nickname)
        self.nickname.snp.makeConstraints{ make in
            make.top.equalTo(408)
            make.left.equalTo(20)
        }
    }
}
