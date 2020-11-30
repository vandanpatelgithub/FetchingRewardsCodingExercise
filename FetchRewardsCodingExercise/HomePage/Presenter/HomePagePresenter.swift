//
//  HomePagePresenter.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/30/20.
//

import Foundation

protocol HomePagePresentable: class {
    func goToTraditionalDataSource()
    func goToDiffableDataSource()
    
    var router: HomePageRouting? { get set }
}

final class HomePagePresenter {
    let view: HomePageViewable
    var router: HomePageRouting?
    
    init(view: HomePageViewable) {
        self.view = view
    }
}

extension HomePagePresenter: HomePagePresentable {
    func goToTraditionalDataSource() {
        router?.goToTraditionalDataSource()
    }
    
    func goToDiffableDataSource() {
        router?.goToDiffableDataSource()
    }
}
