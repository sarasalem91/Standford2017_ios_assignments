//
//  Concentration.swift
//  ConcentrationTask1
//
//  Created by OSX 12 on 6/14/21.
//

import Foundation

// game logic


struct Concentration{
    
    private(set) var cards : [Card] = []
    
    var indexOfOneAndOnlyCard:Int? { // previous index
        get{
            var foundIndx:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndx == nil{
                        foundIndx = index
                    }else{
                        foundIndx = nil
                    }
                    
                }
            }
            return foundIndx
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    var flips_count : Int = 0
    var score = 0
    
    // game concepte
    
    mutating func chooseCard(index : Int){
        flips_count += 1
       
        if let oneIndexAndOnly = indexOfOneAndOnlyCard , oneIndexAndOnly != index{
           
            if cards[oneIndexAndOnly].identifier == cards[index].identifier{
                cards[oneIndexAndOnly].isMatched = true
                cards[index].isMatched = true
                score += 2
            }else{
                if cards[index].isSeenBefore || cards[oneIndexAndOnly].isSeenBefore{
                    score -= 1
                }
                cards[index].isSeenBefore = true
                cards[oneIndexAndOnly].isSeenBefore = true
            }
            
            cards[index].isFaceUp = true
        //indexOfOneAndOnlyCard = nil
            
        }else{
//            for i in 0..<cards.count{
//                cards[i].isFaceUp = false
//            }
//            cards[index].isFaceUp = true
//
//
            
            indexOfOneAndOnlyCard = index
        }
        
    }
    
    mutating  func reset_game(){
        score = 0
        flips_count = 0
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].isSeenBefore = false
        }
    }
    
    
    init(numberOfCards : Int) {
        for _ in 0..<numberOfCards{
            var card = Card()
            cards += [card,card]
        }
        
        // shuffle card
        cards.shuffle()
        
    }
    
}
