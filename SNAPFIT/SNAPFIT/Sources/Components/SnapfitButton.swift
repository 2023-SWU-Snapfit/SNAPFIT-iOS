//
//  SnapfitButton.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/1/23.
//

import UIKit

final class SnapfitButton: UIButton {
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.setTitleColor(.sfWhite, for: .normal)
        self.setTitleColor(.sfBlack60, for: .disabled)
    }
}

extension SnapfitButton {
    private func setUI() {
        self.makeRounded(cornerRadius: 10)
        self.setBackgroundColor(.sfBlack100, for: .normal)
        self.setBackgroundColor(.sfBlack20, for: .disabled)
    }
}
