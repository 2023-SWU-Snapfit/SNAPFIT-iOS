//
//  SignUpSelectPhotoViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/28/23.
//

import UIKit
import SnapKit

final class SignUpSelectPhotoViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backNext)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "관심 있는 콘셉트의\n이미지를 선택해 주세요."
        label.numberOfLines = 2
        label.font = .b24
        label.textColor = .sfBlack100
        return label
    }()
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
    }
    
    // MARK: Methods
    
    
}

// MARK: - UI

extension SignUpSelectPhotoViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, titleLabel])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
