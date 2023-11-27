//
//  BaseViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/14.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    lazy var activityIndicator: SnapfitActivityIndicatorView = {
        let activityIndicator: SnapfitActivityIndicatorView = SnapfitActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = self.view.center
        
        return activityIndicator
    }()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor()
    }
}

// MARK: Methods

extension BaseViewController {
    func hideTabBar() {
        if let tabBarController = self.tabBarController as? SnapfitTabBarController {
            tabBarController.hideTabBar()
        }
    }

    func showTabBar() {
        if let tabBarController = self.tabBarController as? SnapfitTabBarController {
            tabBarController.showTabBar()
        }
    }
    
    /// 화면 터치 시 키보드 내리는 메서드
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// 모든 뷰의 기본 Background color 설정
    private func setBackgroundColor() {
        self.view.backgroundColor = .sfGrayWhite
    }
    
    /// 서버 통신 시작 시 Activity Indicator를 시작하는 메서드
    func startActivityIndicator() {
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    /// 서버 통신이 끝나면 Activity Indicator를 종료하는 메서드
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    
    /// BackButton에 pop Action을 간편하게 주는 메서드.
    /// - 필요 시 override하여 사용
    @objc
    func setBackButtonAction(_ button: UIButton) {
        button.setAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func showNetworkErrorAlert() {
        self.makeAlert(title: Message.networkError.text)
    }
    
    func setUserInfo(accessToken: String, userID: Int, nickname: String, email: String, password: String) {
        UserInfo.shared.accessToken = accessToken
        UserInfo.shared.userID = userID
        UserInfo.shared.nickname = nickname
        
        UserDefaultsManager.email = email
        UserDefaultsManager.password = password
    }
}
