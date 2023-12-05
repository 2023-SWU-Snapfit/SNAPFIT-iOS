//
//  ReviewEditViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/11/07.
//

import UIKit

class ReviewEditViewController: BaseViewController {
    
    // MARK: - Properties
    var review: ReviewPostRequestDTO? = nil
    
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
    private let scoreLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "★ 0"
        label.textColor = .sfBlack100
        label.font = .r16
        return label
    }()
    private let commentsTextView: SnapfitTextView = {
        let view: SnapfitTextView = SnapfitTextView(isEditable: true)
        view.setLetterCount(limit: 200)
        return view
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setData()
        self.setLayout()
    }
    
    // MARK: - Method
    private func setNavigationView() {
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.left.right.equalToSuperview()
        }
    }
    private func setData() {
        if let reviewData = self.review {
            self.titleLabel.text = "\(reviewData.receiverId)님에게 후기 남기기"
            self.scoreLabel.text = "★ \(reviewData.star)"
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
        self.view.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        self.view.addSubview(self.commentsTextView)
        self.commentsTextView.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(96)
        }
    }
    
}
