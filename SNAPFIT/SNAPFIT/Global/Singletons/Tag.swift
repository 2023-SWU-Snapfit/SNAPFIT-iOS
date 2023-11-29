//
//  Tag.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import Foundation

final class Tag {
    static let shared = Tag()
    
    private init() { }
    
    let camera: [TagEntity] = [
        .init(id: 1, name: "필름"),
        .init(id: 2, name: "디지털")
    ]
    
    let peopleCount: [TagEntity] = [
        .init(id: 3, name: "1인"),
        .init(id: 4, name: "2인"),
        .init(id: 5, name: "단체"),
        .init(id: 6, name: "없음")
    ]
    
    let category: [TagEntity] = [
        .init(id: 7, name: "결혼/웨딩"),
        .init(id: 8, name: "아기"),
        .init(id: 9, name: "임신"),
        .init(id: 10, name: "우정"),
        .init(id: 11, name: "프로필"),
        .init(id: 12, name: "학교"),
        .init(id: 13, name: "가족"),
        .init(id: 14, name: "커플"),
        .init(id: 15, name: "여행"),
        .init(id: 16, name: "파티"),
        .init(id: 17, name: "반려동물"),
        .init(id: 18, name: "동호회"),
        .init(id: 19, name: "패션"),
        .init(id: 20, name: "기타")
    ]
    
    let mood: [TagEntity] = [
        .init(id: 21, name: "봄"),
        .init(id: 22, name: "여름"),
        .init(id: 23, name: "가을"),
        .init(id: 24, name: "겨울"),
        .init(id: 25, name: "꽃"),
        .init(id: 26, name: "화사한"),
        .init(id: 27, name: "따뜻한"),
        .init(id: 28, name: "여유로운"),
        .init(id: 29, name: "달콤한"),
        .init(id: 30, name: "사랑스러운"),
        .init(id: 31, name: "그리운"),
        .init(id: 32, name: "센치한"),
        .init(id: 33, name: "아련한"),
        .init(id: 34, name: "폐쇄적인"),
        .init(id: 35, name: "단정한"),
        .init(id: 36, name: "고급스러운"),
        .init(id: 37, name: "고전적인"),
        .init(id: 38, name: "이국적인"),
        .init(id: 39, name: "힙한"),
        .init(id: 40, name: "카리스마있는"),
        .init(id: 41, name: "차가운"),
        .init(id: 42, name: "섹시한"),
        .init(id: 43, name: "강렬한"),
        .init(id: 44, name: "스포티한"),
        .init(id: 45, name: "다채로운")
    ]
}

struct TagEntity {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
