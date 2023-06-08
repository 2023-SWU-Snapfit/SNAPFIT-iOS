//
//  ReservationSuggestionViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/07.
//

import UIKit
import SnapKit

class ReservationSuggestionViewController: BaseViewController {
    
    enum Text{
        static let cancelButtonImage = "icn_x"
        static let title = "예약 문의"
        static let date = "예약 일시"
        static let datePlaceholder = "여기를 눌러서 날짜를 선택해주세요."
        static let suggestion = "예약 내용"
        static let suggestionPlaceholder = "문의하고 싶은 사항을 기재해주세요."
        static let sendButton = "문의 보내기"
    }
    
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
        textView.text = Text.datePlaceholder
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
//        textView.setPlaceholder(text: Text.suggestionPlaceholder)
        return textView
    }()
    let sendButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        button.setTitle(Text.sendButton, for: .normal)
        button.titleLabel?.font = .b14
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
            self.dismiss(animated: true)
        }
    }
    
    private func setTextViewTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        self.dateTextView.addGestureRecognizer(tap)
    }
    
    @objc func showDatePicker(_ sender: UITapGestureRecognizer) {
        lazy var datePickerViewController: SnapfitDatePickerViewController = SnapfitDatePickerViewController()
        datePickerViewController.modalTransitionStyle = .crossDissolve
        datePickerViewController.modalPresentationStyle = .overFullScreen
        self.present(datePickerViewController, animated: true)
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
