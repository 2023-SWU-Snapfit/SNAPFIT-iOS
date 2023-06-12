//
//  PhotoSearchResultTableViewCell.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit
import SnapKit

final class PhotoSearchResultTableViewCell: UITableViewCell {
    
    // MARK: UIComponents
    
    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.makeRounded(cornerRadius: 8)
        return imageView
    }()
    
    private let tagsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .m12
        label.textColor = .sfBlack100
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .m12
        label.textColor = .sfBlack60
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
    
    func setData(data: SearchResult.PhotoSearchResult) {
        self.photoImageView.image = data.image
        self.usernameLabel.text = "by. \(data.username)"
        self.tagsLabel.text = data.tagsText
    }
}

// MARK: - UI

extension PhotoSearchResultTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([photoImageView, usernameLabel, tagsLabel])
        
        self.photoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(101)
        }
        
        self.usernameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.photoImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        self.tagsLabel.snp.makeConstraints { make in
            make.left.equalTo(self.photoImageView.snp.right).offset(16)
            make.top.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(20)
        }
    }
}
