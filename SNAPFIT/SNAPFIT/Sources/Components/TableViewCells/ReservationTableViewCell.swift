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
        static let rightButtonReviewActionIdentifier = "rightButtonReviewAction"
    }
    
    // MARK: - Properties
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = Text.dateFormat
        return formatter
    }()
    var updateDelegate: SendUpdateDelegate?
    var targetID: Int!
    var rightButtonReviewAction: UIAction?
    let identity = UIAction.Identifier(Text.rightButtonReviewActionIdentifier)
    
    // MARK: - UIComponents
    var date: Date = Date()
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
    
    override func prepareForReuse() {
        self.rightButton.removeAction(identifiedBy: UIAction.Identifier(Text.rightButtonReviewActionIdentifier), for: .touchUpInside)
    }
    
    func setRightAction() {
        self.rightButtonReviewAction = UIAction(identifier: self.identity) { _ in
            ReservationService.shared.getReservationDetail(reservationId: self.targetID) { networkResult in
                switch networkResult {
                case .success(let responseData):
                    if let result = responseData as? ReservationDetailResponseDTO {
                        let reviewData = ReviewPostRequestDTO(
                            star: 5,
                            receiverId: result.receiverId != UserInfo.shared.userID ? result.receiverId : result.senderId,
                            photo: Data(),
                            content: "")
                        self.updateDelegate?.sendUpdate(data: reviewData)
                    }
                default:
                    print("setRightButtonServerERR")
                }
            }
        }
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
        self.date = date
        self.dateLabel.text = dateFormatter.string(from: date)
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(self.nameLabel.snp.bottom)
        }
    }
    
    private func setLeftTag(_ isFixed: Bool, _ isFinished: Bool) {
        switch (isFixed, isFinished) {
        case (true, true):
            self.stateButton.isEnabled = true
            self.stateButton.setTitle(Text.tagDday + "\(days(from: date))", for: .normal)
//            self.stateButton.setTitle(Text.tagFinished, for: .normal)
        case (false, true):
            self.stateButton.isEnabled = false
            self.stateButton.setTitle(Text.tagOngoing, for: .normal)
        case (true, false):
            self.stateButton.isEnabled = true
            self.stateButton.setTitle(Text.tagDday + "\(days(from: date))", for: .normal)
        default:
            self.stateButton.isEnabled = false
            self.stateButton.setTitle(Text.tagWait, for: .normal)
        }
        self.contentView.addSubview(self.stateButton)
        self.stateButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setRightButton(_ isFixed: Bool, _ isFinished: Bool) {
        
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        switch (isFixed, isFinished) {
        case (true, true):
            self.rightButton.setAttributedTitle(NSAttributedString(string: Text.buttonReview, attributes: attributes), for: .normal)
            self.rightButton.isEnabled = false
            self.rightButton.isHidden = false
            self.rightButton.addAction(self.rightButtonReviewAction ?? UIAction(handler: { _ in }), for: .touchUpInside)
        case (false, true):
            self.rightButton.setAttributedTitle(NSAttributedString(string: Text.buttonContact, attributes: attributes), for: .normal)
            self.rightButton.isEnabled = true
            self.rightButton.isHidden = false
            self.rightButton.setAction {
                ReservationService.shared.getReservationDetail(reservationId: self.targetID) { networkResult in
                    switch networkResult {
                    case .success(let responseData):
                        if let result = responseData as? ReservationDetailResponseDTO {
                            self.updateDelegate?.sendUpdate(data: result.contactUrl)
                        }
                    default:
                        print("ERR")
                    }
                }
            }
        case (true, false):
            self.rightButton.setAttributedTitle(NSAttributedString(string: Text.buttonReview, attributes: attributes), for: .normal)
            self.rightButton.isEnabled = false
            self.rightButton.isHidden = false
            self.rightButton.addAction(self.rightButtonReviewAction ?? UIAction(handler: { _ in }), for: .touchUpInside)
        default:
            self.rightButton.isHidden = true
        }
        if isFixed || isFinished {
            self.contentView.addSubview(self.rightButton)
            self.rightButton.snp.makeConstraints{ make in
                make.top.equalToSuperview().inset(64)
                make.trailing.equalToSuperview().inset(16)
            }
        }
    }
    
    func setPastReservation() {
        if date <= Date() {
            self.rightButton.isEnabled = true
            self.rightButton.isHidden = false
            let attributes = [NSAttributedString.Key.font : UIFont.b14]
            self.rightButton.setAttributedTitle(NSAttributedString(string: Text.buttonReview, attributes: attributes), for: .normal)
            self.stateButton.isEnabled = true
            self.stateButton.setTitle(Text.tagFinished, for: .normal)
        }
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: Date(), to: date).day! + 1
    }
}
