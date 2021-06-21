//
//  Card.swift
//  ConcentrationTask1
//
//  Created by OSX 12 on 6/14/21.
//

import Foundation

// data type
struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isSeenBefore = false
    private(set) var identifier: Int
    
    private(set) static var identifier_value = 0
    
    static private func getIdentifier()->Int{
        identifier_value += 1
        return identifier_value
    }
    
    init() {
        identifier = Card.getIdentifier()
    }
    
}

// to make card unique key for dictionary
extension Card:Hashable{
    
    var hashValue: Int{
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
