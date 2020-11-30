//
//  HomePageRouter.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/30/20.
//

import UIKit

protocol HomePageRouting: class {
    func goToTraditionalDataSource()
    func goToDiffableDataSource()
    func goToHomePage()
}

final class HomePageRouter {
    let navVC: UINavigationController
    
    init(navVC: UINavigationController) {
        self.navVC = navVC
    }
}

extension HomePageRouter: HomePageRouting {    
    func goToTraditionalDataSource() {
        navVC.pushViewController(ItemsListBuilder.buildItemsListVC(), animated: true)
    }
    
    func goToDiffableDataSource() {
        navVC.pushViewController(ItemsListBuilder.buildItemsListDiffableVC(), animated: true)
    }
    
    func goToHomePage() {
        let vc = HomePageBuilder.buildHomePageVC()
        vc.presenter.router = self
        navVC.pushViewController(vc, animated: true)
    }
}
