//
//  ReservationSuggestionViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/07.
//

import UIKit
import SnapKit

class ReservationSuggestionViewController: BaseViewController, DateDataDelegate {
    
    // MARK: - Properties
    enum Text{
        static let cancelButtonImage = "icn_x"
        static let title = "예약 문의"
        static let date = "예약 일시"
        static let datePlaceholder = "여기를 눌러서 날짜를 선택해주세요."
        static let suggestion = "예약 내용"
        static let suggestionPlaceholder = "문의하고 싶은 사항을 기재해주세요."
        static let sendButton = "문의 보내기"
        static let reservationDateFormat = "YYYY년 MM월 dd일 a hh시 mm분"
        static let lastDateFormat = "YYYY.MM.dd HH:mm"
        static let completeTitle = "예약 문의 완료"
        static let completeMessage = """
        예약 문의 전송이 완료되었습니다.
        상대방이 예약을 수락하면, 연락 가능한 url을 열람할 수 있습니다.
        """
        static let errorTitle = "내용 입력 필수"
        static let errorMessage = "필요한 내용을 전부 채워주세요."
    }
    var reservedDate: Date = Date()
    var targetID: Int = 0
    let reservationDateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = Text.reservationDateFormat
        return formatter
    }()
    let lastDateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = Text.lastDateFormat
        return formatter
    }()
    
    // MARK: - UIComponents
    let contentView: UIView = {
        let view: UIView = UIView()
        view.frame.size = CGSize(width: 335, height: 415)
        view.alignmentRect(forFrame: view.frame)
        view.backgroundColor = .sfWhite
        view.makeRounded(cornerRadius: 10)
        view.layer.borderColor = UIColor.sfBlack100.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.title
        label.font = .b18
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        return label
    }()
    let cancelButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: Text.cancelButtonImage), for: .normal)
        return button
    }()
    let dateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.date
        label.font = .m13
        return label
    }()
    let dateTextView: SnapfitTextView = {
        let textView: SnapfitTextView = SnapfitTextView(isEditable: false)
        textView.setFont(font: .m13)
        textView.setPlaceholder(text: Text.datePlaceholder)
        textView.isSelectable = false
        return textView
    }()
    let suggestionTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.suggestion
        label.font = .m13
        return label
    }()
    let suggestionTextView: SnapfitTextView = {
        let textView: SnapfitTextView = SnapfitTextView(isEditable: true)
        textView.setFont(font: .m13)
        textView.setPlaceholder(text: Text.suggestionPlaceholder)
        return textView
    }()
    let sendButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: Text.sendButton, attributes: attributes), for: .normal)
        button.titleLabel?.textColor = .sfWhite
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 10)
        return button
    }()

    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNotification()
        self.setButtonActions()
        self.setTextViewTapGesture()
        self.setLayout()
    }
    
    // MARK: - Mehods
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveContentViewCenter), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveContentViewUpside), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setButtonActions() {
        self.cancelButton.setAction {
            self.dismiss(animated: true)
        }
        self.sendButton.setAction {
            if self.dateTextView.text == "" || self.suggestionTextView.text == "" {
                self.makeAlert(title: Text.errorTitle, message: Text.errorMessage, okAction: nil)
            } else {
                ReservationService.shared.postReservation(data: ReservationPostRequestDTO(receiverId: self.targetID, dateTime: self.reservedDate, content: self.suggestionTextView.text)) { networkResult in
                    switch networkResult {
                    case .success(_):
                        self.makeAlert(title: Text.completeTitle, message: Text.completeMessage, okAction: { _ in
                            self.dismiss(animated: true)
                        })
                    default:
                        self.makeAlert(title: "오류 발생", message: Message.networkError.text, okAction: { _ in  })
                    }
                }
            }
        }
    }
    
    private func setTextViewTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        self.dateTextView.addGestureRecognizer(tap)
    }
    
    public func setUserData(userID: Int) {
        self.targetID = userID
    }
    
    @objc func showDatePicker(_ sender: UITapGestureRecognizer) {
        lazy var datePickerViewController: SnapfitDatePickerViewController = SnapfitDatePickerViewController()
        datePickerViewController.dataDelegate = self
        datePickerViewController.modalTransitionStyle = .crossDissolve
        datePickerViewController.modalPresentationStyle = .overFullScreen
        self.present(datePickerViewController, animated: true)
    }
    
    public func recieveDateData(date: Date) {
        self.dateTextView.text = self.reservationDateFormatter.string(from: date)
        self.reservedDate = date
    }
    
    // MARK: - Layout Methods
    @objc func moveContentViewUpside(_ notification: Notification) {
        let d = notification.userInfo!
        var r = (d[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        r = self.contentView.convert(r, from:nil)
        self.contentView.snp.updateConstraints{ make in
            make.centerY.equalTo((self.view.frame.height - r.height) / 2)
        }
    }
    
    @objc func moveContentViewCenter(_ notification: Notification) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.snp.updateConstraints{ make in
            make.centerY.equalTo(self.view.frame.height / 2)
        }
    }
    
    private func setLayout() {
        self.view.backgroundColor = .sfBlack100.withAlphaComponent(0.5)
        self.view.addSubview(contentView)
        self.contentView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.frame.height / 2)
            make.width.equalTo(335)
            make.height.equalTo(415)
        }
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        self.contentView.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints{ make in
            make.top.right.equalToSuperview().inset(8)
        }
        self.contentView.addSubview(self.dateTitleLabel)
        self.dateTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.dateTextView)
        self.dateTextView.snp.makeConstraints{ make in
            make.top.equalTo(self.dateTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.suggestionTitleLabel)
        self.suggestionTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.dateTitleLabel.snp.bottom).offset(72)
            make.left.right.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.suggestionTextView)
        self.suggestionTextView.snp.makeConstraints{ make in
            make.top.equalTo(self.suggestionTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(143)
        }
        self.contentView.addSubview(self.sendButton)
        self.sendButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}
