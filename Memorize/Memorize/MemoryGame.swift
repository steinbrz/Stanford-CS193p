//
//  MemoryGame.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 5/3/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? // Initialized to Optional<Int>.none
    
    private(set) var score: Int
    
    
    
    mutating func choose(card: Card){ // Need mutating keyword for function that will change struct
        // Find the index of the chosen card(if it exists), check its not face up, and its not matched already
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // This checks if we already have a face up card
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // If chosen cards content matches the card that is already face up content
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].alreadySeen {score -= 1}
                    else {cards[chosenIndex].alreadySeen = true}
                    
                    if cards[potentialMatchIndex].alreadySeen {score -= 1}
                    else { cards[potentialMatchIndex].alreadySeen = true }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
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
        score = 0
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var alreadySeen: Bool = false
        var content: CardContent
        var id: Int
        
    }
}



