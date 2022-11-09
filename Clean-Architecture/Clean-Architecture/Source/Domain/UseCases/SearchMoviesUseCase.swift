//
//  SearchMoviesUseCase.swift
//  Clean-Architecture
//
//  Created by 정은희 on 2022/09/18.
//

import Foundation

protocol SearchMoviesUseCase {
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    // 유즈케이스(도메인 레이어)에서 레포지토리(데이터 레이어)에 접근하기 위한 인터페이스 선언
    // 정리에서는 출입문이라고 했는데 벽을 뚫는다고 생각해도 좋은거같다
    private let moviesRepository: MoviesRepository
    private let moviesQueriesRepository: MoviesQueriesRepository
    
    init(moviesRepository: MoviesRepository, moviesQueriesRepository: MoviesQueriesRepository) {
        self.moviesRepository = moviesRepository
        self.moviesQueriesRepository = moviesQueriesRepository
    }
    
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        return moviesRepository.fetchMoviesList(query: requestValue.query, page: requestValue.page) { result in
            
            if case .success = result {
                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }
            
            completion(result)
        }
    }
}

// Repository Interfaces {
// protocol이라 인상깊다
protocol MoviesRepository {
    func fetchMoviesList(query: MovieQuery, page: Int, completion: Result<MoviesPage, Error> -> Void) -> Cancellable?
}

protocol MoviesQueriesRepository {
    func fetchRecentQueries(maxCount: Int, completion: @escaping  (Result<[MovieQuery], Error>) -> Void)
    func saveRecentQuery(query: MovieQuery,  (Result<[MovieQuery], Error>) -> Void)
}
