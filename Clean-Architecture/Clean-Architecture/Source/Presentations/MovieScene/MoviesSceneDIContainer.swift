//
//  MoviesSceneDIContainer.swift
//  Clean-Architecture
//
//  Created by 정은희 on 2022/09/18.
//

import Foundation

// MARK: - Movies Queries Suggestions List
func makeMoviesQueriesSuggestionsListViewController(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> UIViewController {
   if #available(iOS 13.0, *) { // SwiftUI
       let view = MoviesQueryListView(viewModelWrapper: makeMoviesQueryListViewModelWrapper(didSelect: didSelect))
       return UIHostingController(rootView: view)
   } else { // UIKit
       return MoviesQueriesTableViewController.create(with: makeMoviesQueryListViewModel(didSelect: didSelect))
   }
}
