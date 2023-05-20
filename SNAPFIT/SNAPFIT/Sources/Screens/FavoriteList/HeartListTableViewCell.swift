//
//  HeartListTableCell.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/14.
//

import UIKit
import SnapKit

class HeartListTableViewCell: UITableViewCell {
    let picture = UIImageView()
    let title = UILabel()
    let heartButton = UIButton()
    
    func setPicture() {
        self.picture.image = UIImage(named: "AppIcon")
        self.picture.layer.cornerRadius = 25
        self.picture.layer.borderWidth = 1
        self.picture.layer.borderColor = UIColor.clear.cgColor
        self.picture.clipsToBounds = true
        self.picture.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.picture)
        self.picture.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(50)
        }
    }
    
    func setTitle(titleText: String) {
        self.title.text = titleText
        self.contentView.addSubview(self.title)
        self.title.snp.makeConstraints{ make in
            make.left.equalTo(self.picture.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
    }

    func setRightButton() {
        self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        self.heartButton.tintColor = .sfMainRed
        self.contentView.addSubview(self.heartButton)
        self.heartButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }
    
}
