//
//  Extensions.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/17/20.
//

import UIKit

extension Array where Element == Item {
    func sortByItemNumber() -> [Item] {
        return sorted {
            guard let firstName = $0.name,
                  let secondName = $1.name,
                  !firstName.isEmpty,
                  !secondName.isEmpty else { return false }
            let firstItemNumber = Int(firstName.split(separator: " ").last ?? "") ?? 0
            let secondItemNumber = Int(secondName.split(separator: " ").last ?? "") ?? 0
            return firstItemNumber < secondItemNumber
        }
    }
    
    func removeEmptyOrNilNames() -> [Item] {
        return filter { (item) -> Bool in
            guard let item = item.name else { return false }
            return !item.isEmpty
        }
    }
}

extension Int {
    var sectionTitle: String {
        return "List \(self)"
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
