//
//  SnapfitActivityIndicatorView.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/14.
//

import UIKit

final class SnapfitActivityIndicatorView: UIActivityIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.color = .sfMainRed
        self.hidesWhenStopped = true
        self.style = .medium
        self.stopAnimating()
    }
}
