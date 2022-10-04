//
//  DetailMoviesRepository.swift
//  Clean-Architecture
//
//  Created by 정은희 on 2022/09/18.
//

import Foundation

// DataLayer

final class DetailMoviesRepository {
    
    private let dataTransferService: DataTransfer
    
    init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DetailMoviesRepository: MoviesRepository {
    public func fetchMoviesList(query: MoviesQuery, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancelable? {
        
        let endpoint = APIEndpoints.getMovies(with: MoviesRequestDTD(query: query.query,
                                                                     page: page))
        return dataTransferService.request(with: endpoint) { (response Result<MoviesResponseDTO, Error>) in
            switch response {
            case .success(let moviesResponseDTD):
                completion(.success(moviesResponseDTD.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: DTO (Data Transfer Object)
// DataTransferService 내부에서 JSON Response를 도메인으로 인코딩/디코딩하기 위한 중간 객체로 사용
struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}

struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [MovieDTO]
}

// MARK: Mappings to Domain
extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: page,
                     totalPages: totalPages,
                     movies: movies.map { $0.toDomain() })
    }
}
