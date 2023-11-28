//
//  ReservatinDetailViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/29.
//

import UIKit

class ReservationDetailViewController: BaseViewController {
    enum Text {
        static let navigationTitle = "예약 확인"
        static let senderTitle = "보낸 사람"
        static let recieverTitle = "받는 사람"
        static let dateTitle = "예약 일시"
        static let contentsTitle = "예약 내용"
        static let chatlinkTitle = "연락 가능한 채팅방"
        static let urlButtonTitle = "연락처 URL 열람 활성화하기"
        static let confirmButtonTitle = "예약 확정하기"
    }
    
    // MARK: - Properties
    var reservationID: Int = -1
    var isConfirmed: Bool = false
    var isOpenUrl: Bool = false
    var senderID: Int = -1
    
    // MARK: - UI Components
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backTitle)
        view.setTitle(Text.navigationTitle)
        return view
    }()
    private let senderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.senderTitle
        label.font = .m13
        return label
    }()
    private let profileImageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(named: "AppIcon")
        view.makeRounded(cornerRadius: 25)
        return view
    }()
    private let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = .r14
        return label
    }()
    private let dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.dateTitle
        label.font = .m13
        return label
    }()
    private let dateTextView: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: false)
        view.text = "\(Date())"
        return view
    }()
    private let contentsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.contentsTitle
        label.font = .m13
        return label
    }()
    private let contentsTextView: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: false)
        view.text = ""
        return view
    }()
    private let chatlinkLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.chatlinkTitle
        label.font = .m13
        return label
    }()
    private let chatilinkTextView: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: false)
        view.text = "open.kakao.com/link=2931e77ois22dd2h11"
        return view
    }()
    private let urlButton: UIButton = {
        let button: UIButton = UIButton()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: Text.urlButtonTitle, attributes: attributes), for: .normal)
        button.configuration = .filled()
        button.titleLabel?.textColor = .sfWhite
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 10)
        return button
    }()
    private let confirmButton: UIButton = {
        let button: UIButton = UIButton()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: Text.confirmButtonTitle, attributes: attributes), for: .normal)
        button.configuration = .filled()
        button.titleLabel?.textColor = .sfWhite
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 10)
        return button
    }()

    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setData()
        self.setConfirmButtonAction()
        self.setUrlButtonAction()
        self.setLayout()
    }
    
    // MARK: - Methods
    private func setNavigationView() {
        self.navigationView.backButton.setAction {
            self.dismiss(animated: true)
        }
    }
    
    private func setData() {
        ReservationService.shared.getReservationDetail(reservationId: self.reservationID) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? ReservationDetailResponseDTO {
                    self.reservationID = result.id
                    self.isConfirmed = result.isConfirmed
                    self.isOpenUrl = result.isOpenUrl
                    self.senderID = result.senderId
                    if UserInfo.shared.userID == result.receiverId {
                        self.senderLabel.text = Text.senderTitle
                        self.profileImageView.setImageUrl(result.senderProfileImageUrl ?? "")
                        self.nameLabel.text = "\(result.senderNickname) 님"
                        self.dateTextView.text = self.toReservationString(self.toReservationDate(result.dateTime) ?? Date())
                        self.contentsTextView.text = result.content
                    } else {
                        self.senderLabel.text = Text.recieverTitle
                        self.profileImageView.setImageUrl(result.receiverProfileImageUrl ?? "")
                        self.nameLabel.text = "\(result.receiverNickname) 님"
                        self.dateTextView.text =  self.toReservationString(self.toReservationDate(result.dateTime) ?? Date())
                        self.contentsTextView.text = result.content
                    }
                }
                self.setButtonStyle(self.isConfirmed, self.isOpenUrl)
                self.setChatLinkLayout(self.isConfirmed, self.isOpenUrl)
                self.setButtonLayout(self.isConfirmed, self.isOpenUrl)
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
    
    func setConfirmButtonAction() {
        self.confirmButton.setAction {
            self.makeAlertWithCancel(okTitle: "확인") { _ in
                ReservationService.shared.putReservation(data: ReservationPutRequestDTO(reservationId: self.reservationID, type: .confirm)) { networkResult in
                    switch networkResult {
                    case .success:
                        break
                    default:
                        self.makeAlert(title: "오류 발생", message: "다시 시도해주세요.")
                    }
                }
                self.confirmButton.isEnabled = false
            }
        }
    }
    
    func setUrlButtonAction() {
        self.urlButton.setAction {
            self.makeAlertWithCancel(okTitle: "확인") { _ in
                ReservationService.shared.putReservation(data: ReservationPutRequestDTO(reservationId: self.reservationID, type: .url)) { networkResult in
                    switch networkResult {
                    case .success:
                        print("urlOK")
                    default:
                        self.makeAlert(title: "오류 발생", message: "다시 시도해주세요.")
                    }
                }
                self.urlButton.isEnabled = false
            }
        }
    }
    
    private func setButtonStyle(_ isFixed: Bool, _ isFinished: Bool) {
        if self.senderID == UserInfo.shared.userID {
            self.urlButton.isHidden = true
            self.confirmButton.isHidden = true
            return
        }
        switch (isFixed, isFinished) {
            case (true, true):
                self.urlButton.isEnabled = false
                self.confirmButton.isEnabled = false
            case (false, true):
                self.urlButton.isEnabled = false
                self.confirmButton.isEnabled = true
            case (true, false):
                self.urlButton.isEnabled = false
                self.confirmButton.isEnabled = false
            default:
                self.urlButton.isEnabled = true
                self.confirmButton.isEnabled = true
        }
    }
    
    private func toReservationDate(_ targetString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssssZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: targetString) {
            return date
        } else {
            return nil
        }
    }
    
    private func toReservationString(_ targetDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일 a hh시 mm분"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: targetDate)
    }
    
    // MARK: - Layout Methods
    private func setChatLinkLayout(_ isFixed: Bool, _ isFinished: Bool) {
        if self.senderID == UserInfo.shared.userID && (self.isConfirmed == true || self.isOpenUrl == true){
            self.view.addSubview(self.chatlinkLabel)
            self.chatlinkLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(520)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            self.view.addSubview(self.chatilinkTextView)
            self.chatilinkTextView.snp.makeConstraints { make in
                make.top.equalTo(self.chatlinkLabel.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
    
    private func setLayout() {
        self.view.addSubviews([navigationView])
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(self.senderLabel)
        self.senderLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(104)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubView(self.profileImageView)
        self.profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.senderLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(50)
        }
        self.view.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(self.profileImageView)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(9)
        }
        self.view.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubview(self.dateTextView)
        self.dateTextView.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubview(self.contentsLabel)
        self.contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateTextView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubview(self.contentsTextView)
        self.contentsTextView.snp.makeConstraints { make in
            make.top.equalTo(self.contentsLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(144)
        }
    }
    
    private func setButtonLayout(_ isFixed: Bool, _ isFinished: Bool) {
        if self.senderID != UserInfo.shared.userID {
            self.view.addSubview(self.confirmButton)
            self.confirmButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(44)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            self.view.addSubview(self.urlButton)
            self.urlButton.snp.makeConstraints { make in
                make.bottom.equalTo(self.confirmButton.snp.top).offset(-16)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
}
