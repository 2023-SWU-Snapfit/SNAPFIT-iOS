//
//  TagCollectionViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit
import SnapKit

final class TagCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.font = .r12
        label.textColor = .sfBlack60
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .sfBlack100
                titleLabel.textColor = .sfWhite
            } else {
                contentView.backgroundColor = .sfWhite
                titleLabel.textColor = .sfBlack60
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
        self.contentView.addSubviews([titleLabel])
        
        self.titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.contentView.backgroundColor = .sfWhite
        self.contentView.makeRounded(cornerRadius: self.contentView.frame.height / 2)
        self.contentView.layer.borderColor = UIColor.sfBlack60.cgColor
        self.contentView.layer.borderWidth = 1
    }
    
    // MARK: Methods
    
    func setData(title: String) {
        self.titleLabel.text = title
        self.titleLabel.sizeToFit()
    }
}
