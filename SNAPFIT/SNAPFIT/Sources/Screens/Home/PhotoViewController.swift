//
//  PhotoViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/13.
//

import UIKit
import SnapKit

final class PhotoViewController: BaseViewController {
    
    // MARK: Properties
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .back)
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.view.backgroundColor = .sfBlack100.withAlphaComponent(0.7)
        self.hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.showTabBar()
    }
    
    func setData(image: UIImage) {
        self.imageView.image = image
    }
}

// MARK: - UI

extension PhotoViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, imageView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(594)
        }
    }
}
