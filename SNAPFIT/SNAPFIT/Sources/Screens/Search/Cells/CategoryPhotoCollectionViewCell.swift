//
//  CategoryPhotoCollectionViewCell.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit
import SnapKit

final class CategoryPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .sfBlack100.withAlphaComponent(0.5)
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .r14
        label.textColor = .sfWhite
        label.textAlignment = .center
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
        self.contentView.addSubviews([imageView, blackView, titleLabel])
        
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.contentView.backgroundColor = .sfWhite
        self.contentView.makeRounded(cornerRadius: 8)
    }
    
    // MARK: Methods
    
    func setData(image: UIImage, title: String) {
        self.imageView.image = image
        self.titleLabel.text = title
    }
}
