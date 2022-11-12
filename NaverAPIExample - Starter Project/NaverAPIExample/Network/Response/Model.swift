//
//  Model.swift
//  NaverAPIExample
//
//  Created by MBP04 on 2018. 4. 5..
//  Copyright © 2018년 codershigh. All rights reserved.
//

import Foundation

// Entity에 해당
struct Movie: Codable, Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.query == rhs.query && lhs.results == rhs.results
    }
    
    let query: String
    let results: [MovieInfo]
}

struct MovieInfo: Codable, Equatable {
    // 외부에서 들어오는 파일이 없으므로 lhs, rhs 관련 함수를 따로 추가하지 않았음
    
    let title: String
    let link: String
    let imageURL: String
//    let image: UIImage    // url로 받아와 뷰모델에서 구현할 것이므로 생략
    let pubDate: String
    let director: String
    let actors: String
    let userRating: String
}
