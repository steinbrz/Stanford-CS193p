//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 5/3/21.
//
//  This is the implementation of the view model
import SwiftUI



class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚲", "🚂", "🚁", "🚜", "✈️", "🚀", "🚗", "🚢", "⛵️", "🚄", "🚎", "🚃", "🚔", "🚠", "🚑", "🛺", "🏍", "🚐", "🛵", "🏎", "🛴"] // lecture code has 24
    
    @Published private var model: MemoryGame<String> = createMemoryGame() // Cannot call function before init, circumvented by using static func
    // This @Published behavior works because MemoryGame<CardContent> is a struct and Swift can notice changes in structs
    
    
    static func createMemoryGame() -> MemoryGame<String> { // Can
        MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            emojis[pairIndex]
        }
        
    }

    
    // MARK: - Access to Model
    
    var cards: Array<MemoryGame<String>.Card>{ // Computed variable
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card){
        return model.choose(card: card)
    }
    
    
}
