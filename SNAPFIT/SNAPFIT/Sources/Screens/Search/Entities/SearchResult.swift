//
//  SearchResult.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit

struct SearchResult {
    let photos: [PhotoSearchResult]
    let users: [SummaryUser]
    
    struct PhotoSearchResult {
        let image: UIImage
        let tagsText: String
        let username: String
    }
}

struct SummaryUser {
    let userId: Int
    let image: UIImage
    let username: String
    let isPhotographer: Bool
}
