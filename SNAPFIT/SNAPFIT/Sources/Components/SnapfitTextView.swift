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
    
    private let placeholderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .sfBlack40
        label.font = .r14
        label.numberOfLines = 0
        return label
    }()
    private let letterCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0/10"
        label.font = .m13
        label.textColor = .sfBlack40
        label.numberOfLines = 1
        return label
    }()
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
        self.isScrollEnabled = true
        self.backgroundColor = .sfWhite
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.sfBlack60.cgColor
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.textContainer.size = CGSize(width: 10, height: 30)
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
        self.textContainer.size = CGSize(width: 10, height: 30)
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
    
    public func setFont(font: UIFont) {
        self.font = font
        self.placeholderLabel.font = font
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
    
    public func setLetterCount(limit: Int) {
        self.setLetterCountLayout()
        
        self.rx.text.distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.letterCountLabel.text = "\(self.text.count)/\(limit)"
                if owner.text.count > limit {
                    owner.text = "\(self.text.prefix(10))"
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setLetterCountLayout() {
        self.textInputView.addSubview(self.letterCountLabel)
        self.letterCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.textInputView.snp.top)
            make.trailing.equalToSuperview().inset(self.textContainerInset)
        }
        self.textInputView.clipsToBounds = false
        self.clipsToBounds = false
    }
    
    public func banEnter() {
        self.rx.text.distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                if owner.text.hasSuffix("\n") {
                    owner.text = owner.text.trimmingCharacters(in: ["\n"])
                    owner.endEditing(true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    public func setText(text: String = "") {
        if text == "" && !self.isEditable {
            setClearStyle()
        }
        self.text = text
    }
    
    public func getCount() -> Int {
        return self.text.count
    }
}
