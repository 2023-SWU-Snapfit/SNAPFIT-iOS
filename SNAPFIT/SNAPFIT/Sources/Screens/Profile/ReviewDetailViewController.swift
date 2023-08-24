//
//  ReviewDetailViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/08/22.
//

import UIKit

class ReviewDetailViewController: BaseViewController {
    
    // MARK: - Properties
    var review: Review? = nil
    
    // MARK: - UI Components
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .back)
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
    private let commentsTextView: UITextView = {
        let view: UITextView = UITextView()
        view.font = .m13
        view.textColor = .sfBlack100
        view.backgroundColor = .clear
        view.isEditable = false
        view.isSelectable = false
        view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.textContainer.maximumNumberOfLines = 3
        view.textContainer.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
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
        self.navigationView.backButton.setAction {
            self.navigationController?.popViewController(animated: true)
        }
    }
    private func setData() {
        if let reviewData = self.review {
            self.titleLabel.text = "\(reviewData.userName)님의 후기"
            self.scoreLabel.text = "★ \(reviewData.score)"
        }
        self.commentsTextView.text = self.review?.contentText
        if let newImage = self.review?.image {
            imageView.image = newImage
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
            make.bottom.equalToSuperview().offset(-80)
        }
    }
}
