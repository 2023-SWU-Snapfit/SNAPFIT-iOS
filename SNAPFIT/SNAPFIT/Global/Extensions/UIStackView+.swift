//
//  UIStackView+.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/14.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews() {
            let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
                self.removeArrangedSubview(subview)
                return allSubviews + [subview]
            }
            // Deactivate all constraints
            NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
            // Remove the views from self
            removedSubviews.forEach({ $0.removeFromSuperview() })
        }
}
