//
//  HomePhotoByThemeTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/06/08.
//

import UIKit
import SnapKit

final class HomePhotoByThemeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = .b18
        titleLabel.textColor = .sfBlack100
        return titleLabel
    }()
    
    private let photoContentView: UIView = {
        let view: UIView = UIView()
        view.clipsToBounds = true
        view.makeRounded(cornerRadius: 8)
        view.backgroundColor = .sfWhite
        return view
    }()
    
    let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let tagLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .r14
        label.textColor = .sfBlack100
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setData(title: String, image: UIImage, tagsText: String) {
        self.titleLabel.text = title
        self.photoImageView.image = image
        self.tagLabel.text = tagsText
    }
}

// MARK: - UI

extension HomePhotoByThemeTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([titleLabel, photoContentView])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        self.photoContentView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(26)
        }
        
        self.photoContentView.addSubviews([photoImageView, tagLabel])
        
        self.photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(196)
        }
        
        self.tagLabel.snp.makeConstraints { make in
            make.top.equalTo(self.photoImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
