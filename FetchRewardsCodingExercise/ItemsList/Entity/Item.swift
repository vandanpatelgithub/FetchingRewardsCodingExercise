//
//  Item.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/17/20.
//

import Foundation

struct Item: Codable, Hashable {
    let id: Int
    let listId: Int
    let name: String?
}

struct Section: Hashable {
    
    let sectionName: String
    let identifier = UUID()
    
    init(sectionName: String) {
        self.sectionName = sectionName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
