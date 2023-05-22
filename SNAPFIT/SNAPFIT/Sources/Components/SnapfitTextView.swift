//
//  TextboxViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SnapfitTextView: UITextView {
    
    private let placeholderLabel: UILabel = UILabel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Initialization
    public init(isEditable: Bool) {
        super.init(frame: .zero, textContainer: nil)
        if isEditable {
            self.setEditableStyle()
            self.setActiveStyle()
        } else {
            self.setNotEditableStyle()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Style Methods
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
    
    private func setActiveStyle() {
        self.rx.didBeginEditing
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.layer.borderColor = UIColor.sfBlack60.cgColor
                owner.layer.borderWidth = 2
            })
            .disposed(by: disposeBag)
        
        self.rx.didEndEditing
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.layer.borderColor = UIColor.sfBlack60.cgColor
                owner.layer.borderWidth = 1
            })
            .disposed(by: disposeBag)
    }
    
    private func setPlaceholderLayout() {
        self.textInputView.addSubview(placeholderLabel)
        
        self.placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(self.textContainerInset.top)
            make.left.equalToSuperview().inset(self.textContainerInset.left + 4)
            make.right.equalToSuperview().inset(self.textContainerInset.right)
            make.bottom.equalToSuperview().inset(self.textContainerInset.bottom)
        }
    }
    
    public func setPlaceholder(text: String) {
        self.placeholderLabel.textColor = .sfBlack40
        self.placeholderLabel.font = .r14
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.text = text
        self.setPlaceholderLayout()
        
        self.rx.text
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                if owner.text.isEmpty {
                    owner.placeholderLabel.isHidden = false
                } else {
                    owner.placeholderLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        self.rx.didEndEditing
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                if owner.text.isEmpty {
                    owner.placeholderLabel.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    public func setText(text: String = "") {
        if text == "" {
            setClearStyle()
        }
        self.text = text
    }
}
