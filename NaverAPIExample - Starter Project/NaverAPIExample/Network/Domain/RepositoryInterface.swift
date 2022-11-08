//
//  RepositoryInterface.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

protocol MovieRepoInterface {
    func getSearchResultsFor(query: String, completion: @escaping (Result<Movie, Error>) -> ())
}
