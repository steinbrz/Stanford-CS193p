//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 5/3/21.
//
//  This is the implementation of the view model
import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚲", "🚂", "🚁", "🚜", "✈️", "🚀", "🚗", "🚢", "⛵️", "🚄", "🚎", "🚃", "🚔", "🚠", "🚑", "🛺", "🏍", "🚐", "🛵", "🏎", "🛴"] // lecture code has 24
    
    @Published private var model = createMemoryGame() // Cannot call function before init, circumvented by using static func
    // This @Published behavior works because MemoryGame<CardContent> is a struct and Swift can notice changes in structs
    
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
            emojis[pairIndex]
        }
    }

    
    // MARK: - Access to Model
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
        return model.choose(card)
    }
    
    
}
