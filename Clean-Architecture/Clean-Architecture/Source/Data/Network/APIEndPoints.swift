//
//  APIEndPoints.swift
//  Clean-Architecture
//
//  Created by 정은희 on 2022/09/18.
//

import Foundation

// Infra Layer (= Network Layer)

struct APIEndpoints {
    
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {

        return Endpoint(path: "search/movie/",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }
}


let config = ApiDataNetworkConfig(baseURL: URL(string: appConfigurations.apiBaseURL)!,
                                  queryParameters: ["api_key": appConfigurations.apiKey])
let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                           config: config)

let endpoint = APIEndpoints.getMovies(with: MoviesRequestDTO(query: query.query,
                                                             page: page))
dataTransferService.request(with: endpoint) { (response: Result<MoviesResponseDTO, Error>) in
    let moviesPage = try? response.get()
}
