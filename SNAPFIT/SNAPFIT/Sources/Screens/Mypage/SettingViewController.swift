//
//  SettingViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/08/29.
//

import UIKit

class SettingViewController: BaseViewController {
    
    enum Text {
        static let navigationTitle = "설정"
    }
    // MARK: - UIComponents
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backTitle)
        return view
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
    }
    
    private func setNavigationView() {
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.left.right.equalToSuperview()
        }
        self.navigationView.backButton.setAction {
            self.dismiss(animated: true)
        }
        self.navigationView.setTitle(Text.navigationTitle)
    }
}
