//
//  Music.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import Foundation

//MARK: - 데이터 모델

// 실제 API에서 받게 되는 정보

struct WebtoonData: Codable {
    let webtoons: [Webtoon]
}

// 실제 우리가 사용하게될 음악(Music) 모델 구조체
// (서버에서 가져온 데이터만 표시해주면 되기 때문에 일반적으로 구조체로 만듦)

struct Webtoon: Codable {
    let songName: String?
    let artistName: String?
    let albumName: Int?
    let previewUrl: String?
    let imageUrl: String?
    let releaseDate: String?
    
    // 네트워크에서 주는 이름을 변환하는 방법 (원시값)
    // (서버: trackName ===> songName)
    enum CodingKeys: String, CodingKey {
        case songName = "title"
        case artistName = "author"
        case albumName = "webtoonId"
        case previewUrl = "url"
        case imageUrl = "img"
        case releaseDate = "service"
    }
    
    // (출시 정보에 대한 날짜를 잘 계산하기 위해서) 계산 속성으로
    // "2011-07-05T12:00:00Z" ===> "yyyy-MM-dd"
    var releaseDateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return "2023-09-18"
        }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
}
