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
    private let serviceManager: ServiceManagale
    
    init(presenter: ItemsListPresentable, serviceManager: ServiceManagale) {
        self.presenter = presenter
        self.serviceManager = serviceManager
    }
}

extension ItemsListInteractor: ItemsListInteractable {
    func fetchItems() {
        serviceManager.fetchItems { [weak self] (result) in
            guard let self = self else { return }
            self.presenter.didFetchItems(result)
        }
    }
}
