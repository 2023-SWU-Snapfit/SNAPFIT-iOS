//
//  SnapfitUserInformationEditingViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/08/25.
//

import UIKit
import SnapKit

class SnapfitUserInformationEditingViewController: BaseViewController {
    
    enum Text {
        static let nicknamePlaceholder = "이름을 입력해주세요."
        static let instagramSign = "icn_instagram"
        static let instagramPlaceholder = "인스타그램 아이디를 입력해주세요."
        static let mailSign = "icn_mail"
        static let mailPlaceholder = "메일 주소를 입력해주세요."
        static let pictureSign = "icn_picture"
        static let introduce = "소개글"
        static let introducePlaceholder = "소개글을 작성해주세요."
        static let possibleDate = "예약 가능 날짜"
        static let possibleDatePlaceholder = "예약 가능 날짜에 대한 설명을 작성해주세요."
        static let price = "촬영 비용"
        static let pricePlaceholder = "촬영 비용에 대한 설명을 작성해주세요."
    }
    
    // MARK: - Properties
    private var isPhotographer: Bool = false
    private var isApproved: Bool = false
    private let imagePicker: UIImagePickerController = UIImagePickerController()
    private var isSelectProfile: Bool = true
    
    // MARK: - UIComponents
    private let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .sfGrayWhite
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    private let contentView: UIView = UIView()
    private let bannerImageView: UIImageView = {
        let bannerImageView: UIImageView = UIImageView()
        bannerImageView.setImageColor(color: .sfBlack40)
        bannerImageView.backgroundColor = .sfBlack20
        return bannerImageView
    }()
    private let bannerOverlayView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.image = UIImage(named: Text.pictureSign)
        view.contentMode = .center
        return view
    }()
    private let profileImageView: UIImageView = {
        let profileImageView: UIImageView = UIImageView()
        profileImageView.setImageColor(color: .sfBlack40)
        profileImageView.backgroundColor = .sfBlack40
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        return profileImageView
    }()
    private let profileOverlayView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.image = UIImage(named: Text.pictureSign)
        view.contentMode = .center
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }()
    private let nicknameTextView: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: true)
        view.setEditableStyle()
        view.setFont(font: .m13)
        view.setPlaceholder(text: Text.nicknamePlaceholder)
        view.setLetterCount(limit: 10)
        view.banEnter()
        view.isScrollEnabled = false
        return view
    }()
    private let instagramSignImageView: UIImageView = {
        let instagramSignImageView: UIImageView = UIImageView()
        instagramSignImageView.image = UIImage(named: Text.instagramSign)
        instagramSignImageView.contentMode = .scaleAspectFit
        instagramSignImageView.tintColor = .black
        return instagramSignImageView
    }()
    private let instagramTextField: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: true)
        view.setEditableStyle()
        view.setFont(font: .m13)
        view.setPlaceholder(text: Text.instagramPlaceholder)
        view.banEnter()
        view.isScrollEnabled = false
        return view
    }()
    private let mailSignImageView: UIImageView = {
        let mailSignImageView: UIImageView = UIImageView()
        mailSignImageView.image = UIImage(named: Text.mailSign)
        mailSignImageView.contentMode = .scaleAspectFit
        mailSignImageView.tintColor = .black
        return mailSignImageView
    }()
    private let mailTextField: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: true)
        view.setEditableStyle()
        view.setFont(font: .m13)
        view.setPlaceholder(text: Text.mailPlaceholder)
        view.banEnter()
        view.isScrollEnabled = false
        return view
    }()
    private let introduceTitleLabel: UILabel = {
        let possibleDateTitleLabel: UILabel = UILabel()
        possibleDateTitleLabel.text = Text.introduce
        possibleDateTitleLabel.font = .m13
        return possibleDateTitleLabel
    }()
    private let introduceTextView: SnapfitTextView = {
        let textView: SnapfitTextView = SnapfitTextView(isEditable: true)
        textView.setEditableStyle()
        textView.setFont(font: .m13)
        textView.setPlaceholder(text: Text.introducePlaceholder)
        return textView
    }()
    private let possibleDateTitleLabel: UILabel = {
        let possibleDateTitleLabel: UILabel = UILabel()
        possibleDateTitleLabel.text = Text.possibleDate
        possibleDateTitleLabel.font = .m13
        return possibleDateTitleLabel
    }()
    private let possibleDateTextView: SnapfitTextView = {
        let possibleDateTextView: SnapfitTextView = SnapfitTextView(isEditable: true)
        possibleDateTextView.setPlaceholder(text: Text.possibleDatePlaceholder)
        possibleDateTextView.setFont(font: .m13)
        return possibleDateTextView
    }()
    private let priceTitleLabel: UILabel = {
        let priceTitleLabel: UILabel = UILabel()
        priceTitleLabel.text = Text.price
        priceTitleLabel.font = .m13
        return priceTitleLabel
    }()
    private let priceTextView: SnapfitTextView = {
        let priceTextView: SnapfitTextView = SnapfitTextView(isEditable: true)
        priceTextView.setPlaceholder(text: Text.pricePlaceholder)
        priceTextView.setFont(font: .m13)
        return priceTextView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    public func setEditingActions() {
        self.setNotification()
        self.setTextViewDelegate()
        self.setOneTapAction()
        self.setImagePicker()
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveContentViewCenter), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveContentViewUpside), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setOneTapAction() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc private func tapBackground() {
        self.view.endEditing(true)
    }
    
    public func addAtContentView(component: UIView) {
        self.contentView.addSubview(component)
    }
    
    public func getNewUserInformation() -> User {
        let newUser = User(userName: self.nicknameTextView.text, isApproved: self.isApproved, isPhotographer: self.isPhotographer, instagramID: self.instagramTextField.text, emailAddress: self.mailTextField.text, introduceText: self.introduceTextView.text, possibleDateText: self.possibleDateTextView.text, priceText: self.priceTextView.text)
        return newUser
    }
    
    public func setIsPhotographer(state: Bool){
        self.isPhotographer = state
    }
    
    public func setApproved(approveState: Bool) {
        self.isApproved = approveState
    }
    
    public func setNickname(text: String) {
        self.nicknameTextView.text = text
    }
    
    public func setInstagramText(text: String) {
        self.instagramTextField.text = text
    }
    
    public func setMailText(text: String) {
        self.mailTextField.text = text
    }

    public func setIntroduceText(text: String) {
        self.introduceTextView.setText(text: text)
    }
    
    public func setPossibleDateText(text: String) {
        self.possibleDateTextView.setText(text: text)
    }
    
    public func setPriceText(text: String) {
        self.priceTextView.setText(text: text)
    }
    
    public func setProfileImage(profileImage: UIImage?) {
        if let newImage = profileImage {
            self.profileImageView.image = newImage
        }
    }
    
    public func setBannerImage(bannerImage: UIImage?) {
        if let newImage = bannerImage {
            self.bannerImageView.image = newImage
        }
    }
    
    public func setBasicData(isApproved: Bool, nicknameText: String, instagramText: String) {
        self.setApproved(approveState: isApproved)
        self.setNickname(text: nicknameText)
        self.setInstagramText(text: instagramText)
    }
    
    @objc func moveContentViewUpside(_ notification: Notification) {
        let d = notification.userInfo!
        let r = (d[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if isPhotographer {
            self.priceTextView.snp.updateConstraints{ make in
                make.bottom.equalToSuperview().inset(r.height)
            }
        } else {
            self.introduceTextView.snp.updateConstraints{ make in
                make.bottom.equalToSuperview().inset(r.height)
            }
        }
    }
    
    @objc func moveContentViewCenter(_ notification: Notification) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        if isPhotographer {
            self.priceTextView.snp.updateConstraints{ make in
                make.bottom.equalToSuperview().inset(20)
            }
        } else {
            self.introduceTextView.snp.updateConstraints{ make in
                make.bottom.equalToSuperview().inset(20)
            }
        }
    }
}

extension SnapfitUserInformationEditingViewController {
    
    // MARK: - LayoutMethods
    public func setPhotographerLayout() {
        self.isPhotographer = true
        self.contentView.addSubview(self.bannerImageView)
        self.bannerImageView.snp.makeConstraints{ make in
            make.top.width.equalToSuperview()
            make.height.equalTo(320)
        }
        self.contentView.addSubview(self.bannerOverlayView)
        self.bannerOverlayView.snp.makeConstraints{ make in
            make.top.width.equalToSuperview()
            make.height.equalTo(320)
        }
        self.setEssentialUILayout(profileImageTopConstraint: 270)
        self.setInstagramLayout()
        self.setMailLayout()
        self.setIntroduceLayout()
        self.setPossibleDateAndPriceLayout()
    }
    
    public func setGeneralUserLayout() {
        self.isPhotographer = false
        self.setEssentialUILayout(profileImageTopConstraint: 104)
        self.setInstagramLayout()
        self.setMailLayout()
        self.setIntroduceLayout()
    }
    
    private func setEssentialUILayout(profileImageTopConstraint: ConstraintRelatableTarget) {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints{ make in
            make.bottom.left.right.width.equalToSuperview()
            if isPhotographer {
                make.top.equalTo(-60)
            } else {
                make.top.equalTo(-48)
            }
        }
        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.contentView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(profileImageTopConstraint)
            make.left.equalTo(20)
            make.height.width.equalTo(100)
        }
        self.contentView.addSubview(self.profileOverlayView)
        self.profileOverlayView.snp.makeConstraints{ make in
            make.top.equalTo(profileImageTopConstraint)
            make.left.equalTo(20)
            make.height.width.equalTo(100)
        }
        self.contentView.addSubview(self.nicknameTextView)
        self.nicknameTextView.snp.makeConstraints{ make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setInstagramLayout() {
        self.contentView.addSubview(self.instagramSignImageView)
        self.instagramSignImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.nicknameTextView.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.height.equalTo(20)
        }
        self.contentView.addSubview(self.instagramTextField)
        self.instagramTextField.snp.makeConstraints{ make in
            make.centerY.equalTo(self.instagramSignImageView.snp.centerY)
            make.left.equalTo(self.instagramSignImageView.snp.right).offset(8)
            make.right.equalTo(self.nicknameTextView.snp.right)
            make.height.equalTo(44)
        }
    }
    
    private func setMailLayout() {
        self.contentView.addSubview(self.mailSignImageView)
        self.mailSignImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.instagramTextField.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.height.equalTo(20)
        }
        self.contentView.addSubview(self.mailTextField)
        self.mailTextField.snp.makeConstraints{ make in
            make.centerY.equalTo(self.mailSignImageView.snp.centerY)
            make.left.equalTo(self.mailSignImageView.snp.right).offset(8)
            make.right.equalTo(self.nicknameTextView.snp.right)
            make.height.equalTo(44)
        }
    }
    
    private func setIntroduceLayout() {
        self.view.addSubview(self.introduceTitleLabel)
        self.introduceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.mailTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
        }
        self.contentView.addSubview(self.introduceTextView)
        self.introduceTextView.snp.makeConstraints{ make in
            make.top.equalTo(self.introduceTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(134)
            if !isPhotographer {
                make.bottom.equalToSuperview().inset(20)
            }
        }
    }
    
    private func setPossibleDateAndPriceLayout() {
        self.contentView.addSubview(self.possibleDateTitleLabel)
        self.possibleDateTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.introduceTextView.snp.bottom).offset(24)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.possibleDateTextView)
        self.possibleDateTextView.snp.makeConstraints{ make in
            make.top.equalTo(self.possibleDateTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(20)
            make.height.equalTo(134)
            make.width.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.priceTitleLabel)
        self.priceTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.possibleDateTextView.snp.bottom).offset(24)
            make.left.equalTo(20)
        }
        self.contentView.addSubview(self.priceTextView)
        self.priceTextView.snp.makeConstraints{ make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(20)
            make.height.equalTo(134)
            make.width.bottom.equalToSuperview().inset(20)
        }
    }
}

extension SnapfitUserInformationEditingViewController: UITextViewDelegate {
    func setTextViewDelegate() {
        self.nicknameTextView.delegate = self
        self.mailTextField.delegate = self
        self.instagramTextField.delegate = self
        self.introduceTextView.delegate = self
        self.possibleDateTextView.delegate = self
        self.priceTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isPhotographer {
            let offset: CGFloat = textView.frame.origin.y - 400
            if self.scrollView.frame.size.height + offset > self.contentView.frame.height {
                self.scrollView.setContentOffset(CGPoint(x:0, y: self.scrollView.frame.height - 300), animated: true)
            } else {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
            }
        } else {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 60), animated: true)
        }
    }
}

extension SnapfitUserInformationEditingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func setImagePicker() {
        self.imagePicker.delegate = self
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        self.profileImageView.isUserInteractionEnabled = true
        
        self.bannerImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectBannerImage)))
        self.bannerImageView.isUserInteractionEnabled = true
    }
    private func openLibrary() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.present(self.imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if isSelectProfile {
                self.profileImageView.image = image
            } else {
                self.bannerImageView.image = image
            }
        }
        self.dismiss(animated: true)
    }
    
    @objc func selectProfileImage() {
        self.isSelectProfile = true
        self.openLibrary()
    }
    
    @objc func selectBannerImage() {
        self.isSelectProfile = false
        self.openLibrary()
    }
}
