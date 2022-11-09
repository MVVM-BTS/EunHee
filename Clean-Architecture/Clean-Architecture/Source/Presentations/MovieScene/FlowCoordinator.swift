//
//  FlowCoordinator.swift
//  Clean-Architecture
//
//  Created by 정은희 on 2022/09/18.
//

import Foundation

protocol MoviesSearchFlowCoordinatorDependencies  {
    func makeMoviesListViewController() -> UIViewController
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController
}

final class MoviesSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSearchFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // 액션 클로저를 참조 (flow 할당이 중간에 해제되지 않도록 강한 참조를 유지함)
        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails)
        let vc = dependencies.makeMoviesListViewController(actions: actions)
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showMovieDetails(movie: Movie) {
        // MoviesList ViewModel 의 Actions에 showMovieDetails (movie:) 기능을 할당
        let vc = dependencies.makeMoviesDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}
