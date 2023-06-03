//
//  VerticalPhotoCollectionViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/06/03.
//

import UIKit
import SnapKit

final class VerticalPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .r12
        label.textColor = .sfBlack100
        label.textAlignment = .left
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
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(248)
        }
        
        self.usernameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.top.equalTo(self.imageView.snp.bottom).offset(16)
            make.height.equalTo(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setUI() {
        self.contentView.backgroundColor = .sfWhite
        self.contentView.makeRounded(cornerRadius: 8)
    }
    
    // MARK: Methods
    
    func setData(image: UIImage, username: String) {
        self.imageView.image = image
        self.usernameLabel.text = "by. " + username
    }
}
