//
//  SignUpUserInfoViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/28/23.
//

import UIKit
import SnapKit

final class SignUpUserInfoViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backNext)
        return view
    }()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let contentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .sfGrayWhite
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "회원 정보를\n입력해 주세요."
        label.numberOfLines = 2
        label.font = .b24
        label.textColor = .sfBlack100
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "img_emptyProfile"))
        return imageView
    }()
    
    private let photoButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        return button
    }()
    
    private let emailTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "이메일 (필수, 프로필에 공개됩니다.)"
        return textField
    }()
    
    private let emailCheckButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton(type: .system)
        button.setTitle("중복 확인", for: .normal)
        return button
    }()
    
    private let passwordTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "비밀번호 (필수)"
        return textField
    }()
    
    private let nicknameTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "닉네임 (필수)"
        return textField
    }()
    
    private let nicknameCheckButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton(type: .system)
        button.setTitle("중복 확인", for: .normal)
        return button
    }()
    
    private let instagramTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "인스타그램 ID (프로필에 공개됩니다.)"
        return textField
    }()
    
    private let costTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "촬영 비용 안내"
        return textField
    }()
    
    private let contactUrlTextField: SnapfitTextField = {
        let textField: SnapfitTextField = SnapfitTextField()
        textField.placeholder = "카카오톡 오픈채팅 url, 포트폴리오 url 등 연락처"
        return textField
    }()
    
    // MARK: Properties
    
    private var keyboardHeight: CGFloat = 0
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setTextFieldDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addKeyboardObserver(willShow: #selector(self.keyboardWillShow(_:)), willHide: #selector(self.keyboardWillHide(_:)))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.removeKeyboardObserver()
    }
    
    // MARK: Methods
    
    private func setNextButtonAction() {
        self.navigationView.nextButton.setAction { [weak self] in
            self?.navigationController?.pushViewController(SignUpSelectPhotoViewController(), animated: true)
        }
    }
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    
    private func setTextFieldDelegate() {
        self.nicknameTextField.delegate = self
        self.instagramTextField.delegate = self
        self.costTextField.delegate = self
        self.contactUrlTextField.delegate = self
    }
}

extension SignUpUserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.setContentOffset(
            CGPoint(x: 0, y: self.emailTextField.frame.minY - 20),
            animated: true
        )
        
        self.scrollView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(self.keyboardHeight + 20)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.scrollView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        
        self.scrollView.setContentOffset(
            CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.height),
            animated: true
        )
    }
}

// MARK: - UI

extension SignUpUserInfoViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, scrollView])
        self.scrollView.addSubview(contentView)
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        self.contentView.addSubviews([titleLabel, photoImageView, emailTextField, emailCheckButton, passwordTextField, nicknameTextField, nicknameCheckButton, instagramTextField, photoButton])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        self.photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.width.height.equalTo(80).priority(.required)
            make.centerX.equalToSuperview()
        }
        
        self.photoButton.snp.makeConstraints { make in
            make.edges.equalTo(self.photoImageView)
        }
        
        self.emailCheckButton.snp.makeConstraints { make in
            make.top.equalTo(self.photoImageView.snp.bottom).offset(24)
            make.height.equalTo(48)
            make.width.equalTo(84)
            make.right.equalToSuperview().inset(20)
        }
        
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.photoButton.snp.bottom).offset(24)
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(self.emailCheckButton.snp.left).offset(-8)
        }
        
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.nicknameCheckButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(84)
        }
        
        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(self.nicknameCheckButton.snp.left).offset(-8)
        }
        
        if SignUpRequestData.shared.position == "PHOTOGRAPHER" {
            self.contentView.addSubviews([costTextField, contactUrlTextField])
            
            self.instagramTextField.snp.makeConstraints { make in
                make.top.equalTo(self.nicknameTextField.snp.bottom).offset(16)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(48)
            }
            
            self.costTextField.snp.makeConstraints { make in
                make.top.equalTo(self.instagramTextField.snp.bottom).offset(16)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(48)
            }
            
            self.contactUrlTextField.snp.makeConstraints { make in
                make.top.equalTo(self.costTextField.snp.bottom).offset(16)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(48)
                make.bottom.equalToSuperview().inset(40)
            }
        } else {
            self.instagramTextField.snp.makeConstraints { make in
                make.top.equalTo(self.nicknameTextField.snp.bottom).offset(16)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(48)
                make.bottom.equalToSuperview().inset(40)
            }
        }
    }
}
