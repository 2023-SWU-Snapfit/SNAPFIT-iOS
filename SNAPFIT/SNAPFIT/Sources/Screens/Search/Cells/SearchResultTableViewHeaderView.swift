//
//  SearchResultTableViewHeaderView.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit
import SnapKit

final class SearchResultTableViewHeaderView: UITableViewHeaderFooterView {
    
    enum Text {
        static let rightArrowImageName = "icn_rightArrow_verySmall"
        static let more = "더보기"
    }
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = .b18
        titleLabel.textColor = .sfBlack100
        return titleLabel
    }()
    
    lazy var moreButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: Text.rightArrowImageName), for: .normal)
        button.setTitle(Text.more, for: .normal)
        button.titleLabel?.font = .r14
        button.tintColor = .sfBlack60
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    // MARK: Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setLayout(searchType: SearchType) {
        switch searchType {
        case .photo:
            self.setDefaultLayout()
            self.setMoreLayout()
            self.titleLabel.text = "사진 검색 결과"
        case .user:
            self.setDefaultLayout()
            self.titleLabel.text = "유저 검색 결과"
        }
    }
    
    private func setDefaultLayout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(129)
        }
        
        self.moreButton.removeFromSuperview()
    }
    
    private func setMoreLayout() {
        self.addSubview(self.moreButton)
        
        self.moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
    }
}
