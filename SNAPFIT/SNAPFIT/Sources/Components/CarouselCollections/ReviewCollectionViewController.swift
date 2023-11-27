//
//  ReviewCollectionViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/19.
//

import UIKit
import SnapKit

class ReviewCollectionViewController: UIViewController {
    
    // MARK: - Properties
    private var avgStars: Float = 0.0
    private var numOfItems: Int = 0
    private var reviews: [UserReviewList] = []
    var reviewDataDelegate: ReviewDataDelegate?
    
    // MARK: - UI Components
    let titleLabel = UILabel()
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.itemSize = CGSize(width: 126, height: 98)
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 10, height: 10), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollection()
        self.setComponents()
    }
    
    
    
    // MARK: - Methods
    public func setReview(reviews: [UserReviewList], avgStars: Float) {
        self.numOfItems = reviews.count
        self.reviews = reviews
        self.avgStars = avgStars
        self.titleLabel.text = "리뷰(★ \(String(format: "%.1f", self.avgStars)))"
        self.collectionView.reloadData()
    }
    
    public func setDelegate(_ receiver: SnapfitUserInformationViewController) {
        self.reviewDataDelegate = receiver
    }
    
    private func setCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reviewCell")
    }
    
    private func setComponents() {
        self.titleLabel.text = "리뷰(★ \(String(format: "%.1f", self.avgStars)))"
        self.titleLabel.font = .b18
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalTo(20)
        }
        self.view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension ReviewCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: [REVIEW] 리뷰 상세보기로 연결하기
//        self.reviewDataDelegate?.sendReview(data: self.reviews[indexPath.row])
    }
}

extension ReviewCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath)
        let reviewImage = UIImageView()
        let score = UILabel()
        let reviewDetails = UITextView()
        
        cell.backgroundColor = .sfWhite
        cell.layer.borderColor = UIColor.sfBlack60.cgColor
        cell.layer.borderWidth = 1
        cell.makeRounded(cornerRadius: 8)
        
        reviewImage.backgroundColor = .sfBlack40
        reviewImage.setImageUrl(self.reviews[indexPath.row].photoUrl)
        reviewImage.contentMode = .scaleAspectFill
        reviewImage.makeRounded(cornerRadius: 8)
        
        score.text = "★ \(reviews[indexPath.row].star)"
        score.textColor = .sfMainRed
        score.font = .m13
        
        cell.addSubview(reviewImage)
        reviewImage.snp.makeConstraints{ make in
            make.top.left.equalTo(8)
            make.width.equalTo(110)
            make.height.equalTo(80)
        }
        cell.addSubview(score)
        score.snp.makeConstraints{ make in
            make.top.equalTo(reviewImage.snp.bottom).offset(8)
            make.left.equalTo(8)
            make.height.equalTo(20)
        }
        return cell
    }
}
