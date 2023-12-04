//
//  MainPhoto.swift
//  SNAPFIT
//
//  Created by Jungbin on 12/4/23.
//

import UIKit

class MainPhoto {
    static var shared = MainPhoto()
    
    init() { }
    
    var data: GetMainTagPhotoResponseDTO = GetMainTagPhotoResponseDTO(tagPhoto: [.init(tagName: "", photos: [])], personal: [], season: [])
}
