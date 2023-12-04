//
//  SearchResult.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit

struct SearchResult {
    var photos: [PhotoSearchResult]
    var users: [SummaryUser]
    
    struct PhotoSearchResult {
        let imageURL: String
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
