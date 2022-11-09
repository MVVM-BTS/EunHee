//
//  DefaultMoviesListViewModel.swift
//  Clean-Architecture
//
//  Created by 정은희 on 2022/09/18.
//

import Foundation
import RxSwift

protocol MoviesListViewModelInput {
    func didSearch(query: String)
    func didSelect(at indexPath: IndexPath)
}
    protocol MoviesListViewModelOutput {
    var items: Observable<[MoviesListItemViewModel]> { get }
    var error: Observable<String> { get }
}
    
struct MoviesListViewModelActions {
    // 화면에 들어갈 세부 사항을 수정하거나 업데이트 하고 싶다면 아래 클로저 이용! ↓
    // showMovieDetails: (Movie, @escaping (_ updated: Movie) -> Void) -> Void
    let showMovieDetails: (Movie) -> Void
}


final class DefaultMoviesListViewModel: MoviesListViewModel {
    private let searchMoviesUseCase: SearchMoviesUseCase
    private let actions: MoviesListViewModelActions?
    
    private var movies: [Movie] = []    // entity
    
    // Output
    let items: Observable<[MoviesListItemViewModel]> = Observable([])
    let error: Observable<String> = Observable("")
    
    init(searchMoviesUseCase: SearchMoviesUseCase,
         actions: MoviesListViewModelActions) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }
    
    // private 걸어준거 궁금...!!! 뷰에서 로드할때 쓰지 않나요? (이거 어디서 호출함...? 걍 클래스 자체를 갖다쓰는건가)
    private func load(movieQuery: MovieQuery) {
        
        searchMoviesUseCase.execute(movieQuery: movieQuery) { result in
            switch result {
            case .success(let moviesPage):
                // 도메인 계층의 엔티티를 뷰모델 내의 아이템에 만드시 mapping 해야함
                // (= 나누어져 있기 때문)
                self.items.value += moviesPage.movies.map(MoviesListItemViewModel.init)
                self.movies += moviesPage.movies
            case .failure:
                self.error.values = NSLocalizedString("Failed loading movies", comment: "")
            }
        }
    }
}

// viewModel의 이벤트 메서드 input
extension MoviesListViewModel {
    func didSearch(query: String) {
        load(moviequery: MovieQuery(query: query))
    }
    func didSelect(at indexPath: IndexPath) {
        actions?.showMovieDetails(movies[indexPath.row])
    }
}

// viewModel -> 데이터 보여주는 용도임, 뷰에 접근하기 위한 도메인 모델은 포함하지 않음
struct MoviesListItemViewModel: Equatable {
    let title: String
}
extension MoviesListItemViewModel {
    init(movie: Movie) {
        self.title = movie.title ?? ""
    }
}
