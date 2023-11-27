//
//  SignUpSelectPositionViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/22/23.
//

import UIKit
import SnapKit

final class SignUpSelectPositionViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .back)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "포지션을\n선택해 주세요."
        label.numberOfLines = 2
        label.font = .b24
        label.textColor = .sfBlack100
        return label
    }()
    
    private let photographerButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton(type: .system)
        button.setTitle("사진 작가", for: .normal)
        button.setTitleColor(.sfBlack100, for: .normal)
        button.layer.borderColor = UIColor.sfBlack100.cgColor
        button.layer.borderWidth = 1
        button.setBackgroundColor(.sfWhite, for: .normal)
        return button
    }()
    
    private let generalButton: SnapfitButton = {
        let button: SnapfitButton = SnapfitButton(type: .system)
        button.setTitle("일반 사용자, 모델", for: .normal)
        button.setTitleColor(.sfBlack100, for: .normal)
        button.layer.borderColor = UIColor.sfBlack100.cgColor
        button.layer.borderWidth = 1
        button.setBackgroundColor(.sfWhite, for: .normal)
        return button
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setPhotographerButtonAction()
        self.setGeneralButtonAction()
        self.setBackButtonAction()
    }
    
    // MARK: Methods
    
    private func setPhotographerButtonAction() {
        self.photographerButton.setAction { [weak self] in
            SignUpRequestData.shared.position = "PHOTOGRAPHER"
            self?.navigationController?.pushViewController(SignUpVerifyViewController(), animated: true)
        }
    }
    
    private func setGeneralButtonAction() {
        self.generalButton.setAction { [weak self] in
            SignUpRequestData.shared.position = "GENERAL"
            self?.navigationController?.pushViewController(SignUpVerifyViewController(), animated: true)
        }
    }
    
    private func setBackButtonAction() {
        self.navigationView.backButton.setAction {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UI

extension SignUpSelectPositionViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, titleLabel, photographerButton, generalButton])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        self.photographerButton.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        self.generalButton.snp.makeConstraints { make in
            make.top.equalTo(self.photographerButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
