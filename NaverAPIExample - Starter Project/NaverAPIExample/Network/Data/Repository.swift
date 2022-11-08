//
//  Repository.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

struct MovieRepository: MovieRepoInterface {
    
    let manager = APIServiceManager(service: MovieSearchService())
    
    func getSearchResultsFor(query: String, completion: @escaping (Result<Movie, Error>) -> ()) {
        let parameters: [String: Any] = ["q": query]
        self.manager.performAPIRequest(with: parameters) { results, error in
            guard error == nil, let _ = results else {
                return completion(.failure(CustomError.search(type: .notFound)))
            }
            if let entity = results {
                completion(.success(entity)) // toDomain 메서드로 바꿔서 엔티티 모르도록 해야할듯
            }
        }
    }
}
