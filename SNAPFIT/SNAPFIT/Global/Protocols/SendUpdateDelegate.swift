//
//  SendUpdateDelegate.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit

protocol SendUpdateDelegate {
    func sendUpdate(data: Any?)
}

protocol SendImageDelegate {
    func sendUpdate(image: UIImage)
}
