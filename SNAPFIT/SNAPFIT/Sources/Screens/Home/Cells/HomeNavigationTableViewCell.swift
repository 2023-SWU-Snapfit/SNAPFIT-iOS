//
//  HomeNavigationTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit

final class HomeNavigationTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .home)
        return view
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension HomeNavigationTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([navigationView])
        
        self.navigationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
