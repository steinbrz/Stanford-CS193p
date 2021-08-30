//
//  MemoryGame.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 5/3/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly } // oneAndOnly defined in extension at bottom of this file
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    
    
    mutating func choose(_ card: Card){ // Need mutating keyword for function that will change struct
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { // Get the index of the one and only face up card
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true // Currently selected card must be turned face up
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
        print("\(cards)")
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable{
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        let id: Int
        
    }
}

extension Array {
    // if you add a var as an extension, it needs to be computed. Not stored in memory
    var oneAndOnly: Element? {
        if count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}



