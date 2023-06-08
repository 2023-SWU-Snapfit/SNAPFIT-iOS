//
//  SnapfitSearchTextField.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit
import SnapKit

final class SnapfitSearchTextField: UITextField {
    
    enum Text {
        static let placeholder = "분위기, 작가 등을 검색해 보세요."
        static let searchIconImageName = "icn_search"
    }
    
    // MARK: Components
    
    private let leadingView: UIView = UIView(frame: CGRect(x: 4, y: 8, width: 40, height: 32))
    private let searchImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: Text.searchIconImageName))
        imageView.frame = CGRect(x: 8, y: 0, width: 32, height: 32)
        return imageView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setPlaceholderWithColor(placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.sfBlack40])
    }
}

// MARK: - UI

extension SnapfitSearchTextField {
    private func setUI() {
        self.backgroundColor = .sfWhite
        self.makeRounded(cornerRadius: 20)
        self.setPlaceholderWithColor(placeholder: Text.placeholder)
        self.font = .r14
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.sfBlack100.cgColor
        self.leftViewMode = .always
        self.returnKeyType = .search
        self.addRightPadding(16)
    }
    
    private func setLayout() {
        self.leadingView.addSubview(searchImageView)
        self.leftView = self.leadingView
    }
}
