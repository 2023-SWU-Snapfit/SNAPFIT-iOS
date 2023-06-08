//
//  SnapfitSearchBarButton.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/22.
//

import UIKit

final class SnapfitSearchBarButton: UIButton {
    
    // MARK: Components
    
    private let textField: SnapfitSearchTextField = {
        let textField: SnapfitSearchTextField = SnapfitSearchTextField()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
        self.setBackgroundColor(.sfBlack20, for: .highlighted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension SnapfitSearchBarButton {
    private func setLayout() {
        self.addSubview(textField)
        
        self.textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
