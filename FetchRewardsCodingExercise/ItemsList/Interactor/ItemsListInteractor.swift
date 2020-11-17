//
//  ItemsListInteractor.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import Foundation

protocol ItemsListInteractable: class {
    func fetchItems()
}

final class ItemsListInteractor {
    private let presenter: ItemsListPresentable
    
    init(presenter: ItemsListPresentable) {
        self.presenter = presenter
    }
}

extension ItemsListInteractor: ItemsListInteractable {
    func fetchItems() {
        print("DEBUG: Fetching Items")
    }
}
