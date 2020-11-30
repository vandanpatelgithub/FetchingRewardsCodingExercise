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
    var groupedItems = [Int : [Item]]()
    var error = ""
        
    func display(groupedItems: [Int : [Item]]) {
        numberOfTimesDisplayItemsCalled += 1
        self.groupedItems = groupedItems
    }
    
    func display(error: String) {
        numberOfTimesDisplayErrorCalled += 1
        self.error = error
    }
}
