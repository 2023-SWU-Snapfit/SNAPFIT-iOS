//
//  HomeReservationDetailTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit

final class HomeReservationDetailTableViewCell: UITableViewCell {
    
    enum Text {
        static let title = " 님과의 예약이 있어요!"
        static let dDAy = "D-"
        static let rightArrowImageName = "icn_rightArrow_verySmall"
        static let detailButtonTitle = "예약 내역"
    }
    
    // MARK: Properties
    
    private let cardView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .sfWhite
        view.makeRounded(cornerRadius: 8)
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.sfBlack100.cgColor
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.title
        label.font = .r14
        label.textColor = .sfBlack60
        return label
    }()
    
    private let dDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.dDAy
        label.font = .b18
        label.textColor = .sfMainRed
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2023.06.01 14:00"
        label.font = .m12
        label.textColor = .sfBlack100
        return label
    }()
    
    private let detailButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: Text.rightArrowImageName), for: .normal)
        button.setTitle(Text.detailButtonTitle, for: .normal)
        button.titleLabel?.font = .r14
        button.tintColor = .sfBlack60
        button.semanticContentAttribute = .forceRightToLeft
        return button
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
    
    // MARK: Methods
    
    func setData() {
        
    }
}

// MARK: - UI

extension HomeReservationDetailTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([cardView])
        
        self.cardView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        
        self.cardView.addSubviews([titleLabel, dDayLabel, detailButton, dateLabel])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(17)
        }
        
        self.dDayLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(23)
            make.leading.bottom.equalToSuperview().inset(16)
        }
        
        self.detailButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(self.dDayLabel)
            make.height.equalTo(24)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.dDayLabel)
            make.leading.equalTo(self.dDayLabel.snp.trailing).offset(8)
        }
    }
}
