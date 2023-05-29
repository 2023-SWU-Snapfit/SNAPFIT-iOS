//
//  ReservatinDetailViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/29.
//

import UIKit

class ReservationDetailViewController: BaseViewController {
    // MARK: - Properties
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backTitle)
        view.setTitle("예약 확인")
        return view
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    
    // MARK: - Methods
    private func setLayout() {
        self.view.addSubviews([navigationView])
        self.setNavigationView()
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setNavigationView() {
        self.navigationView.backButton.setAction {
            self.dismiss(animated: true)
        }
    }
}
