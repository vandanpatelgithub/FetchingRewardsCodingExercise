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
    func searchResults(forText text: String)
}

final class ItemsListPresenter {
    private let view: ItemsListViewable
    var interactor: ItemsListInteractable!
    var originalFetchedItems = [Int: [Item]]()
    
    init(view: ItemsListViewable) {
        self.view = view
    }
}

extension ItemsListPresenter: ItemsListPresentable {
    func searchResults(forText text: String) {
        if text.isEmpty { view.display(groupedItems: originalFetchedItems) }
        else {
            var filteredItems = originalFetchedItems
            
            filteredItems.forEach { (key, value) in
                let filteredValues = value.filter { ($0.name?.contains(text) ?? false) }
                if filteredValues.isEmpty { filteredItems[key] = nil }
                else { filteredItems.updateValue(filteredValues, forKey: key) }
            }
            view.display(groupedItems: filteredItems)
        }
    }
    
    func didFetchItems(_ completion: Result<[Item], Error>) {
        switch completion {
        case let .success(items):
            let filteredItems = items.removeEmptyOrNilNames()
            
            var groupedItems = Dictionary(grouping: filteredItems) { $0.listId }
            groupedItems.forEach { (key, value) in
                let sortedByName = value.sortByItemNumber()
                groupedItems.updateValue(sortedByName, forKey: key)
            }
            self.originalFetchedItems = groupedItems
            view.display(groupedItems: groupedItems)
        case let .failure(error):
            view.display(error: error.localizedDescription)
        }
    }
    
    func didLoadView() {
        interactor.fetchItems()
    }
}
