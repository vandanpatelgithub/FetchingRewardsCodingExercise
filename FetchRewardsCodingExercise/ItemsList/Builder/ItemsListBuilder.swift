//
//  ItemsListBuilder.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import Foundation

final class ItemsListBuilder {
    static func buildItemsListVC() -> ItemsListVC {
        let vc = ItemsListVC()
        let presenter = ItemsListPresenter(view: vc)
        let interactor = ItemsListInteractor(presenter: presenter)
        presenter.interactor = interactor
        vc.presenter = presenter
        return vc
    }
}
