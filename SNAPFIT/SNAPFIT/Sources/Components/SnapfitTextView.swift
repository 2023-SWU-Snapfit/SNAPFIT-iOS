//
//  TextboxViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/20.
//

import UIKit
import SnapKit

class SnapfitTextView: UITextView {
    
    public init(isEditable: Bool) {
        super.init(frame: .zero, textContainer: nil)
        if isEditable {
            setEditableStyle()
        } else {
            setNotEditableStyle()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setClearStyle() {
        self.sizeToFit()
        self.backgroundColor = .clear
        self.layer.borderWidth = 0
        self.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setEditableStyle() {
        self.font = .r14
        self.textAlignment = .natural
        self.isEditable = true
        self.isScrollEnabled = false
        self.sizeToFit()
        self.backgroundColor = .sfWhite
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.sfBlack60.cgColor
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func setNotEditableStyle() {
        self.font = .r14
        self.textAlignment = .natural
        self.isEditable = false
        self.isScrollEnabled = false
        self.sizeToFit()
        self.backgroundColor = .sfWhite
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.sfBlack60.cgColor
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func setText(text: String = "") {
        if text == "" {
            setClearStyle()
        }
        self.text = text
    }
}
