//
//  ItemsListVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import UIKit

protocol ItemsListViewable: class {
    func display(groupedItems: [Dictionary<Int, [Item]>.Element])
    func display(error: String)
}

final class ItemsListVC: UIViewController {
    
    // presenter is forced-unwrap on purpose. if it is nil, I have nothing to show on view
    var presenter: ItemsListPresentable!
    private var groupedItems = [Dictionary<Int, [Item]>.Element]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
    }
}

extension ItemsListVC: ItemsListViewable {
    func display(groupedItems: [Dictionary<Int, [Item]>.Element]) {
        self.groupedItems = groupedItems
        
        for (key, value) in groupedItems {
            print("Key:: \(key), Value:: \(value)")
        }
    }
    
    func display(error: String) {
    }
}
