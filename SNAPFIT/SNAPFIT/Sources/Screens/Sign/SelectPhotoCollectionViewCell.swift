//
//  SelectPhotoCollectionViewCell.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/28/23.
//

import UIKit
import SnapKit

final class SelectPhotoCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.borderColor = UIColor.sfMainRed.cgColor
                contentView.layer.borderWidth = 4
            } else {
                contentView.layer.borderWidth = 0
            }
        }
    }
    
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
        self.contentView.addSubviews([imageView])
        
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.contentView.backgroundColor = .sfBlack20
        self.contentView.makeRounded(cornerRadius: 8)
    }
    
    // MARK: Methods
    
    func setData(image: UIImage) {
        self.imageView.image = image
    }
}
