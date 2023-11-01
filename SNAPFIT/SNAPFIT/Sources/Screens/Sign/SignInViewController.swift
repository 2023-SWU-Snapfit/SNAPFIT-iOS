//
//  SignInViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/1/23.
//

import UIKit
import SnapKit

final class SignInViewController: BaseViewController {
    
    private enum Text {
        static let title = "매칭부터 촬영까지 내 손 안에"
        static let idPlaceholder = "아이디"
        static let passwordPlaceholder = "비밀번호"
        static let signIn = "로그인"
        static let signUp = "회원가입"
        static let info = "회원가입 시 이용약관과 개인정보 처리 방침에 동의하게 됩니다."
    }
    
    // MARK: UIComponents
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.title
        label.font = .r14
        label.textColor = .sfBlack100
        label.textAlignment = .center
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "logoHor"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let idTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = Text.idPlaceholder
        return textField
    }()
    
    private let passwordTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = Text.passwordPlaceholder
        return textField
    }()
    
    private let signInButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton(type: .system)
        button.setTitle(Text.signIn, for: .normal)
        return button
    }()
    
    private let signUpButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton(type: .system)
        button.setTitle(Text.signUp, for: .normal)
        button.setTitleColor(.sfBlack100, for: .normal)
        button.layer.borderColor = UIColor.sfBlack100.cgColor
        button.layer.borderWidth = 1
        button.setBackgroundColor(.sfWhite, for: .normal)
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.info
        label.font = .r12
        label.textColor = .sfBlack50
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
    }
    
    // MARK: Methods
    
    
}

// MARK: - UI

extension SignInViewController {
    private func setLayout() {
        self.view.addSubviews([titleLabel, titleImageView, idTextField, passwordTextField, infoLabel, signInButton, signUpButton])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        
        self.titleImageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(76)
            make.height.equalTo(61)
        }
        
        self.idTextField.snp.makeConstraints { make in
            make.top.equalTo(self.titleImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.idTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.infoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(66)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(12)
        }
        
        self.signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.infoLabel.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
