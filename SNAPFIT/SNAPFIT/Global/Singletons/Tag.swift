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

extension Int {
    func getTagName() -> String {
        switch self {
        case 1: return "필름"
        case 2: return "디지털"
        case 3: return "1인"
        case 4: return "2인"
        case 5: return "단체"
        case 6: return "없음"
        case 7: return "결혼/웨딩"
        case 8: return "아기"
        case 9: return "임신"
        case 10: return "우정"
        case 11: return "프로필"
        case 12: return "학교"
        case 13: return "가족"
        case 14: return "커플"
        case 15: return "여행"
        case 16: return "파티"
        case 17: return "반려동물"
        case 18: return "동호회"
        case 19: return "패션"
        case 20: return "기타"
        case 21: return "봄"
        case 22: return "여름"
        case 23: return "가을"
        case 24: return "겨울"
        case 25: return "꽃"
        case 26: return "화사한"
        case 27: return "따뜻한"
        case 28: return "여유로운"
        case 29: return "달콤한"
        case 30: return "사랑스러운"
        case 31: return "그리운"
        case 32: return "센치한"
        case 33: return "아련한"
        case 34: return "폐쇄적인"
        case 35: return "단정한"
        case 36: return "고급스러운"
        case 37: return "고전적인"
        case 38: return "이국적인"
        case 39: return "힙한"
        case 40: return "카리스마있는"
        case 41: return "차가운"
        case 42: return "섹시한"
        case 43: return "강렬한"
        case 44: return "스포티한"
        case 45: return "다채로운"
        default: return ""
        }
    }
    
    
}
