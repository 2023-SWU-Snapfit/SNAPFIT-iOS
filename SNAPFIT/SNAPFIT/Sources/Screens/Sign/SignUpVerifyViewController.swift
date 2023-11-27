//
//  SignUpVerifyViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/22/23.
//

import UIKit
import SnapKit

final class SignUpVerifyViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .back)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "휴대폰 번호를\n인증해 주세요."
        label.numberOfLines = 2
        label.font = .b24
        label.textColor = .sfBlack100
        return label
    }()
    
    private let phoneNumberTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "01012341234"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let sendCodeButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton()
        button.setTitle("인증 번호 전송", for: .normal)
        button.titleLabel?.font = .b14
        return button
    }()
    
    private let codeTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "인증 번호 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let enterButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton()
        button.setTitle("인증하기", for: .normal)
        button.titleLabel?.font = .b14
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "원활한 서비스 이용을 위해 휴대폰 인증이 필요합니다."
        label.font = .m13
        label.textColor = .sfBlack60
        return label
    }()
    
    // MARK: Properties
    
    var code: String = ""
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setCodeButtonAction()
        self.setEnterButtonAction()
        self.setBackButtonAction(self.navigationView.backButton)
    }
    
    // MARK: Methods
    
    private func setCodeButtonAction() {
        self.sendCodeButton.setAction {
            let text = "01077221394"
            self.sendCode(data: .init(phoneNumber: text))
        }
    }
    
    private func setEnterButtonAction() {
        self.enterButton.setAction {
            if self.codeTextField.text == self.code {
                self.makeAlert(title: "인증이 완료되었습니다.") { _ in
                    self.present(SignInViewController(), animated: true)
                }
            }
        }
    }
}


// MARK: - UI

extension SignUpVerifyViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, titleLabel, phoneNumberTextField, sendCodeButton, codeTextField, enterButton, infoLabel])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        self.phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(219)
            make.height.equalTo(48)
        }
        
        self.sendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(self.phoneNumberTextField)
            make.left.equalTo(self.phoneNumberTextField.snp.right).offset(8)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(self.phoneNumberTextField)
        }
        
        self.codeTextField.snp.makeConstraints { make in
            make.top.equalTo(self.phoneNumberTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.enterButton.snp.makeConstraints { make in
            make.top.equalTo(self.codeTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.infoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.enterButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
    }
}
