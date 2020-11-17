//
//  ItemsListPresenter.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import Foundation

protocol ItemsListPresentable: class {
    func didLoadView()
}

final class ItemsListPresenter {
    private let view: ItemsListViewable
    var interactor: ItemsListInteractable!
    
    init(view: ItemsListViewable) {
        self.view = view
    }
}

extension ItemsListPresenter: ItemsListPresentable {
    func didLoadView() {
        interactor.fetchItems()
    }
}
