//
//  TextboxViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/20.
//

import UIKit

class TextboxView: UITextView {
    
    func setBasicTextbox() {
        self.font = .r14
        self.textAlignment = .natural
        self.isEditable = false
        self.isScrollEnabled = false
        self.sizeToFit()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.sfBlack60.cgColor
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func setText(text: String =
"""
"""
    ) {
        self.text = text
    }
}
