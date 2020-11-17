//
//  ItemsVCMock.swift
//  FetchRewardsCodingExerciseTests
//
//  Created by Vandan Patel on 11/17/20.
//

import Foundation
@testable import FetchRewardsCodingExercise

class ItemsVCMock: ItemsListViewable {
    var numberOfTimesDisplayItemsCalled = 0
    var numberOfTimesDisplayErrorCalled = 0
    var groupedItems = [Dictionary<Int, [Item]>.Element]()
    var error = ""
    
    func display(groupedItems: [Dictionary<Int, [Item]>.Element]) {
        numberOfTimesDisplayItemsCalled += 1
        self.groupedItems = groupedItems
    }
    
    func display(error: String) {
        numberOfTimesDisplayErrorCalled += 1
        self.error = error
    }
}
