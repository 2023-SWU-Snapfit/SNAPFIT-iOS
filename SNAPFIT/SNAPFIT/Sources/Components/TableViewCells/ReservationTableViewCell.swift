//
//  ReservationTableViewCell.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/07/11.
//

import UIKit
import SnapKit

class ReservationTableViewCell: BorderedTableViewCell {
    
    enum Text {
        static let dateFormat = "YYYY.MM.dd. HH:mm"
        static var tagDday = "D - "
        static let tagFinished = "촬영완료"
        static let tagWait = "예약 문의 대기"
        static let tagOngoing = "예약 조율 중"
        static let buttonContact = "연락하기"
        static let buttonReview = "리뷰 작성"
    }
    
    // MARK: - Properties
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = Text.dateFormat
        return formatter
    }()
    
    // MARK: - UIComponents
    let dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .sfBlack60
        label.font = .m12
        return label
    }()
    let stateButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.tintColor = .sfBlack60
        button.setTitleColor(.sfBlack60, for: .disabled)
        button.configuration = .plain()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .clear
        button.configuration?.background.strokeColor = .sfBlack60
        button.configuration?.background.strokeWidth = 1
        return button
    }()
    let rightButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .sfBlack100
        button.configuration?.background.cornerRadius = 8
        return button
    }()
    
    // MARK: - Method
    override func layoutSubviews() {
        self.frame.size = CGSize(width: self.frame.width, height: 112)
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.sfBlack100.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    func setAsReservationList(userName: String, lastDate: Date, isFixed: Bool, isFinished: Bool) {
        self.setReservationNameLabel(name: userName)
        self.setDate(date: lastDate)
        self.setLeftTag(isFixed, isFinished)
        self.setRightButton(isFixed, isFinished)
    }
    
    private func setReservationNameLabel(name: String) {
        self.nameLabel.text = "\(name) 님"
        self.nameLabel.font = .b18
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setDate(date: Date) {
        self.dateLabel.text = dateFormatter.string(from: date)
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(self.nameLabel.snp.bottom)
        }
    }
    
    private func setLeftTag(_ isFixed: Bool, _ isFinished: Bool) {
        self.stateButton.isEnabled = false
        switch (isFixed, isFinished) {
        case (true, true):
            print("tt")
        case (false, true):
            print("ft")
        case (true, false):
            print("tf")
        default:
            self.stateButton.setTitle(Text.tagWait, for: .normal)
        }
        self.contentView.addSubview(self.stateButton)
        self.stateButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setRightButton(_ isFixed: Bool, _ isFinished: Bool) {
        switch (isFixed, isFinished) {
        case (true, true):
            print("tt")
        case (false, true):
            print("ft")
        case (true, false):
            print("tf")
        default:
            self.rightButton.setTitle(Text.buttonContact, for: .normal)
        }
        self.contentView.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(64)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
