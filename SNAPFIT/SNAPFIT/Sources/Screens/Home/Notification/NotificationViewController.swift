//
//  NotificationViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit
import SnapKit

final class NotificationViewController: BaseViewController {
    
    enum Text {
        static let title = "알림"
    }
    
    // MARK: Properties
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backTitle)
        view.setTitle(Text.title)
        return view
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
    }
    
    // MARK: Methods
}

// MARK: - UI

extension NotificationViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
