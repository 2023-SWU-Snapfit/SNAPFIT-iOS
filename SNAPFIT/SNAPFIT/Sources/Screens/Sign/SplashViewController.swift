//
//  SplashViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/21/23.
//

import UIKit
import SnapKit

final class SplashViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let titleImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "logoHor")
        return imageView
    }()
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
            self.autoSignIn()
        }
        
    }
    
    // MARK: Methods

    private func autoSignIn() {
        let email: String = UserDefaultsManager.email ?? ""
        let password: String = UserDefaultsManager.password ?? ""
        let deviceToken: String = UserInfo.shared.deviceToken
        
        let signInRequestData: SignInRequestDTO = SignInRequestDTO(email: email, password: password, deviceToken: deviceToken)
        
        self.requestSignIn(data: signInRequestData) { response in
            self.setUserInfo(
                accessToken: response.accessToken,
                userID: response.user.userID,
                nickname: response.user.nickname,
                email: email,
                password: password,
                position: response.user.position
            )
            
            let tabBarController = SnapfitTabBarController()
            self.present(tabBarController, animated: true)
        }
    }
}

// MARK: - Network

extension SplashViewController {
    private func requestSignIn(data: SignInRequestDTO, completion: @escaping (SignInResponseDTO) -> ()) {
        self.startActivityIndicator()
        SignService.shared.requestSignIn(data: data) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? SignInResponseDTO {
                    completion(result)
                }
            default:
                let signInViewController = SignInViewController()
                signInViewController.modalPresentationStyle = .fullScreen
                signInViewController.modalTransitionStyle = .crossDissolve
                self.present(SignInViewController(), animated: true)
            }
            self.stopActivityIndicator()
        }
    }
}

// MARK: - UI

extension SplashViewController {
    private func setLayout() {
        self.view.addSubviews([titleImageView])
        
        self.titleImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(253)
            make.height.equalTo(69)
        }
    }
}
