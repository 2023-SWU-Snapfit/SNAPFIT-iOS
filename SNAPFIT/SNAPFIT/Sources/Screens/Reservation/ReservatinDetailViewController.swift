//
//  ReservatinDetailViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/29.
//

import UIKit

class ReservationDetailViewController: BaseViewController {
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .close)
        view.setTitle("예약 확인")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    
    private func setLayout() {
        self.view.addSubviews([navigationView])
        self.setNavigationbar()
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setNavigationbar() {
        // TODO: navigationView 고치고 backButton으로 수정 필요
        self.navigationView.closeButton.setAction {
            self.dismiss(animated: true)
        }
    }
}
