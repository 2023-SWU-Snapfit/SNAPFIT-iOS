//
//  PhotographerCollectionViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/06/07.
//

import UIKit
import SnapKit

final class PhotographerCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .m13
        label.textColor = .sfBlack100
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setLayout() {
        self.contentView.addSubviews([imageView, usernameLabel])
        
        self.imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(self.imageView.snp.width)
        }
        
        self.usernameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(self.imageView.snp.bottom).offset(11)
            make.height.equalTo(32)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setUI() {
        self.contentView.backgroundColor = .sfWhite
        self.contentView.makeRounded(cornerRadius: 8)
        self.imageView.makeRounded(cornerRadius: 64 / 2)
    }
    
    // MARK: Methods
    
    func setData(profileImage: UIImage, username: String) {
        self.imageView.image = profileImage
        self.usernameLabel.text = username
    }
}
