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
        static let privacyPolicy = "개인정보 처리 방침"
        static let terms = "이용약관"
        
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
        textField.isSecureTextEntry = true
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
        label.setHyperlinkedStyle(to: [Text.privacyPolicy, Text.terms], with: .m12)
        return label
    }()
    
    // MARK: Properties
    
    // MARK: Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setSignInButtonAction()
        self.setSignUpButtonAction()
    }
    
    // MARK: Methods
    
    private func setSignInButtonAction() {
        self.signInButton.setAction { [weak self] in
            self?.requestSignIn(data: self?.signInData() ?? SignInRequestDTO(email: "", password: "", deviceToken: ""),
                                completion: { response in
                self?.setUserInfo(
                    accessToken: response.accessToken,
                    userID: response.user.userID,
                    nickname: response.user.nickname,
                    email: self?.idTextField.text ?? "",
                    password: self?.passwordTextField.text ?? ""
                )
                
                let tabBarController = SnapfitTabBarController()
                self?.present(tabBarController, animated: true)
            })
        }
    }
    
    private func signInData() -> SignInRequestDTO {
        let email = self.idTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let deviceToken = UserInfo.shared.deviceToken
        
        return SignInRequestDTO(email: email, password: password, deviceToken: deviceToken)
    }
    
    private func setSignUpButtonAction() {
        self.signUpButton.setAction { [weak self] in
            let vc = BaseNavigationController(rootViewController: SignUpSelectPositionViewController())
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
}

// MARK: - Network

extension SignInViewController {
    private func requestSignIn(data: SignInRequestDTO, completion: @escaping (SignInResponseDTO) -> ()) {
        self.startActivityIndicator()
        SignService.shared.requestSignIn(data: data) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? SignInResponseDTO {
                    completion(result)
                }
            case .requestErr:
                self.makeAlert(title: "아이디 혹은 비밀번호가 맞지 않습니다.")
            default:
                self.showNetworkErrorAlert()
            }
            self.stopActivityIndicator()
        }
    }
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
