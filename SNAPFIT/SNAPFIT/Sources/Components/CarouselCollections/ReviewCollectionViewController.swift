//
//  ReviewCollectionViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/19.
//

import UIKit
import SnapKit

class ReviewCollectionlViewController: UIViewController {
    let collectionView : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.itemSize = CGSize(width: 126, height: 172)
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 10, height: 10), collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reviewCell")
    }
}

extension ReviewCollectionlViewController: UICollectionViewDelegate {
    
}

extension ReviewCollectionlViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath)
        let reviewImage = UIImageView()
        let star = UIImageView(image: UIImage(systemName: "star.fill"))
        let score = UILabel()
        let reviewDetails = UITextView()
        
        cell.backgroundColor = .sfWhite
        cell.layer.borderColor = UIColor.sfBlack60.cgColor
        cell.layer.borderWidth = 1
        cell.makeRounded(cornerRadius: 8)
        
        reviewImage.backgroundColor = .sfBlack40
        reviewImage.makeRounded(cornerRadius: 8)
        
        star.tintColor = .sfMainRed
        star.contentMode = .scaleAspectFit
        
        score.text = "5"
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
        cell.addSubview(star)
        star.snp.makeConstraints{ make in
            make.top.equalTo(reviewImage.snp.bottom).offset(8)
            make.left.equalTo(8)
            make.height.width.equalTo(14)
        }
        cell.addSubview(score)
        score.snp.makeConstraints{ make in
            make.top.equalTo(star)
            make.left.equalTo(star.snp.right)
        }
        cell.addSubview(reviewDetails)
        reviewDetails.snp.makeConstraints{ make in
            make.top.equalTo(star.snp.bottom)
            make.left.equalTo(star)
            make.width.equalTo(reviewImage.snp.width)
            make.bottom.equalToSuperview().inset(8)
        }
        return cell
    }
}
