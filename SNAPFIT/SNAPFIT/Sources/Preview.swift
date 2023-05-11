//
//  Preview.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/11.
//

import SwiftUI

struct ViewToPreview: UIViewControllerRepresentable{

    typealias UIViewControllerType = HomeViewController
    let targetView = HomeViewController()
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return targetView
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct Preview: PreviewProvider {
    static var previews: some View{
        ViewToPreview()
    }
}
