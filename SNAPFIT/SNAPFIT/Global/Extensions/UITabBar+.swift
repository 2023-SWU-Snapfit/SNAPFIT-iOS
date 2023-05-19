//
//  UITabBar+.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/20.
//

import UIKit

extension UITabBar {
    
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
