//
//  ListTableViewCell.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {
    let picture = UIImageView()
    let title = UILabel()
    let subtitle = UILabel()
    let righttitle = UILabel() // MARK: - 뷰컨 옮기기
    let heartButton = UIButton() // MARK: - 뷰컨 옮기기
    
    // TODO: 알맞게 사용할 수 있도록 각각의 요소 분리
    func setPicture() {
        self.picture.image = UIImage(named: "AppIcon")
        self.picture.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.picture)
        self.picture.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.height.width.equalTo(60)
        }
    }
    
    func setTitle(titleText: String) {
        self.title.text = titleText
        self.contentView.addSubview(self.title)
        self.title.snp.makeConstraints{ make in
            make.left.equalTo(self.picture.snp.right).offset(10)
            make.centerY.equalToSuperview().offset(-10)
        }
    }
    
    func setSubtitle(subtitleText: String) {
        self.subtitle.text = subtitleText
        self.contentView.addSubview(self.subtitle)
        self.subtitle.snp.makeConstraints{ make in
            make.left.equalTo(self.title)
            make.top.equalTo(self.title.snp.bottom)
        }
    }
    
    func setRightAsText(rightText: String) {
        self.righttitle.text = rightText
        self.contentView.addSubview(self.righttitle)
        self.righttitle.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(30)
        }
    }
    
    func setRightAsHeartButton() {
        self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        self.heartButton.tintColor = .sfMainRed
        self.contentView.addSubview(self.heartButton)
        self.heartButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(30)
        }
    }
    
}
