//
//  ViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/02.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: Properties
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .closeSave)
        view.setTitle("타이틀")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
    }

}

// MARK: - UI

extension HomeViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
