//
//  ReviewEditViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/11/07.
//

import UIKit
import PhotosUI
import Cosmos

class ReviewEditViewController: BaseViewController {
    
    // MARK: - Properties
    var review: ReviewPostRequestDTO? = nil
    var photosPicker: PHPickerViewController = {
        var config: PHPickerConfiguration = PHPickerConfiguration()
        config.filter = .images
        return PHPickerViewController(configuration: config)
    }()
    
    // MARK: - UI Components
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backSave)
        return view
    }()
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .r24
        return label
    }()
    private let imageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.backgroundColor = .sfBlack40
        view.contentMode = .scaleAspectFill
        view.makeRounded(cornerRadius: 8)
        return view
    }()
    private let ratingView: CosmosView = {
        let view: CosmosView = CosmosView()
        view.settings.updateOnTouch = true
        view.settings.filledColor = .sfMainRed
        view.settings.filledBorderColor = .sfMainRed
        view.settings.emptyBorderColor = .sfBlack50
        view.settings.starSize = 20
        view.settings.starMargin = 2
        view.rating = 5
        return view
    }()
    private let commentsTextView: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: true)
        return view
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setSaveButtonAction()
        self.setImagePicker()
        self.setLayout()
    }
    
    // MARK: - Method
    private func setImagePicker() {
        self.photosPicker.delegate = self
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPHPicker)))
        self.imageView.isUserInteractionEnabled = true
    }
    
    private func setSaveButtonAction() {
        self.navigationView.saveButton.setAction {
            self.review?.content = self.commentsTextView.text
            self.review?.star = Int(self.ratingView.rating)
            if let imageData = self.imageView.image?.pngData() {
                self.review?.photo = imageData
            }
            if let reviewData = self.review, reviewData.content != "", reviewData.photo != Data() {
                self.startActivityIndicator()
                ReviewService.shared.postReview(data: reviewData) { networkResult in
                    switch networkResult {
                    case .success:
                        self.navigationController?.popViewController(animated: true)
                    case .requestErr:
                        print("REQUEST err")
                    case .pathErr:
                        print("PATH err")
                    case .serverErr:
                        print("SERVER err")
                    case .networkFail:
                        print("FAIL err")
                    }
                }
                self.stopActivityIndicator()
            } else {
                self.makeAlert(title: "저장할 수 없습니다.", message: "모든 항목을 다 채워주세요.")
            }
        }
    }
    
    private func setNavigationView() {
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.left.right.equalToSuperview()
        }
    }
    public func setData() {
        if let reviewData = self.review {
            getUserData(targetID: reviewData.receiverId) { result in
                self.titleLabel.text = "\(result.nickname)님에게 후기 남기기"
            }
        }
        self.commentsTextView.text = self.review?.content
        if let newImage = self.review?.photo {
            imageView.image = UIImage(data: newImage)
        }
    }
    private func setLayout() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(216)
        }
        self.view.addSubview(self.ratingView)
        self.ratingView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        self.view.addSubview(self.commentsTextView)
        self.commentsTextView.snp.makeConstraints { make in
            make.top.equalTo(self.ratingView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(96)
        }
    }
    
}

extension ReviewEditViewController: PHPickerViewControllerDelegate {
    
    @objc func openPHPicker() {
        self.present(self.photosPicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.imageView.image = image as? UIImage
                    }
            }
        } else {
            self.makeAlert(title: "사진을 불러올 수 없습니다.", message: "다른 사진을 선택해주세요.")
        }
    }
    
}
