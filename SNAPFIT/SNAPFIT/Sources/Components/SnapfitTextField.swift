//
//  SignTextField.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/1/23.
//

import UIKit
import SnapKit

final class SnapfitTextField: UITextField {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -10, dy: 0)
    }
}

// MARK: - UI

extension SnapfitTextField {
    private func setUI() {
        self.backgroundColor = .sfWhite
        self.makeRounded(cornerRadius: 8)
        self.font = .m13
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.sfBlack100.cgColor
        self.returnKeyType = .done
        self.addLeftPadding(16)
        self.clearButtonMode = .always
    }
}
