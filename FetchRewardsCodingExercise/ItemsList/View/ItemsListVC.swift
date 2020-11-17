//
//  ItemsListVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/16/20.
//

import UIKit

protocol ItemsListViewable: class {
    func display()
}

final class ItemsListVC: UIViewController {
    
    // presenter is forced-unwrap on purpose. if it is nil, I have nothing to show on view
    var presenter: ItemsListPresentable!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
    }
}

extension ItemsListVC: ItemsListViewable {
    func display() {
        print("DEBUG: display...")
    }
}
