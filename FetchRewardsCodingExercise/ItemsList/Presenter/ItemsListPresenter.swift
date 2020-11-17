//
//  ItemsListPresenter.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import Foundation

protocol ItemsListPresentable: class {
    func didLoadView()
    func didFetchItems(_ completion: Result<[Item], Error>)
}

final class ItemsListPresenter {
    private let view: ItemsListViewable
    var interactor: ItemsListInteractable!
    
    init(view: ItemsListViewable) {
        self.view = view
    }
}

extension ItemsListPresenter: ItemsListPresentable {
    func didFetchItems(_ completion: Result<[Item], Error>) {
        switch completion {
        case let .success(items):
            let filteredItems = items.removeEmptyOrNilNames()
            
            var groupedItems = Dictionary(grouping: filteredItems) { $0.listId }
            groupedItems.forEach { (key, value) in
                let sortedByName = value.sortByItemNumber()
                groupedItems.updateValue(sortedByName, forKey: key)
            }
            
            let sortedByListID = groupedItems.sorted { $0.key < $1.key }
            view.display(groupedItems: sortedByListID)
        case let .failure(error):
            view.display(error: error.localizedDescription)
        }
    }
    
    func didLoadView() {
        interactor.fetchItems()
    }
}
