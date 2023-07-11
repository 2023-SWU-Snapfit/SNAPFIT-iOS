//
//  HeartListTableCell.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/14.
//

import UIKit
import SnapKit

class BorderedTableViewCell: UITableViewCell {
    let picture: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size = CGSize(width: self.frame.width, height: 64)
        self.accessoryType = .disclosureIndicator
        self.layer.borderColor = UIColor.sfBlack100.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    func setAsFavoriteList(userImage: UIImage?, userName: String) {
        self.setPicture(userImage)
        self.setFavoriteUserName(name: userName)
    }
    
    private func setPicture(_ newImage: UIImage?) {
        if let image = newImage { self.picture.image = image }
        self.picture.backgroundColor = .sfBlack20
        self.picture.layer.cornerRadius = 20
        self.picture.layer.borderWidth = 1
        self.picture.layer.borderColor = UIColor.clear.cgColor
        self.picture.clipsToBounds = true
        self.picture.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.picture)
        self.picture.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
    }
    
    private func setFavoriteUserName(name: String) {
        self.nameLabel.text = name
        self.nameLabel.font = .m13
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints{ make in
            make.left.equalTo(self.picture.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
}
