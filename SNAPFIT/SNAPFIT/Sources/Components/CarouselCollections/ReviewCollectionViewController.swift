//
//  ReviewCollectionViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/19.
//

import UIKit
import SnapKit

class ReviewCollectionViewController: UIViewController {
    let titleLabel = UILabel()
    let collectionView : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.itemSize = CGSize(width: 126, height: 172)
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 10, height: 10), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "리뷰(★5.0)"
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reviewCell")
    }
}

extension ReviewCollectionViewController: UICollectionViewDelegate {
    
}

extension ReviewCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
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
        reviewImage.makeRounded(cornerRadius: 8)
        
        score.text = "★ 5"
        score.textColor = .sfMainRed
        score.font = .m13
        
        reviewDetails.text = "후기 텍스트 뷰 구현 중 입니다. 임시 내용으로 총 3줄까지 표기됩니다. 별점 아래에 살세 후기를 일부 보여줍니다."
        reviewDetails.font = .m13
        reviewDetails.textColor = .sfBlack100
        reviewDetails.isScrollEnabled = false
        reviewDetails.isEditable = false
        reviewDetails.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        reviewDetails.textContainer.maximumNumberOfLines = 3
        reviewDetails.textContainer.lineBreakMode = .byTruncatingTail
        
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
        }
        cell.addSubview(reviewDetails)
        reviewDetails.snp.makeConstraints{ make in
            make.top.equalTo(score.snp.bottom)
            make.left.equalTo(score)
            make.width.equalTo(reviewImage.snp.width)
            make.bottom.equalToSuperview().inset(8)
        }
        return cell
    }
}
