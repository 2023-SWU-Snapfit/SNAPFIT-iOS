//
//  HomeSearchBarTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit

final class HomeSearchBarTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    let searchButton: SnapfitSearchBarButton = {
        let view: SnapfitSearchBarButton = SnapfitSearchBarButton(type: .system)
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

extension HomeSearchBarTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([searchButton])
        
        self.searchButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
