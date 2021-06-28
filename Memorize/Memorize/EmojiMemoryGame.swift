//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 5/3/21.
//
//  This is the implementation of the view model
import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    private var themes: ThemeModel
    
    @Published private var model: MemoryGame<String> // Cannot call function before init, circumvented by using static func
    // This @Published behavior works because MemoryGame<CardContent> is a struct and Swift can notice changes in structs
    
    init() {
        themes = ThemeModel()
        model = EmojiMemoryGame.createMemoryGame(emojis: themes.getEmojis()!, numPairs: themes.getNumPairs()!)
    }
    
    
    static func createMemoryGame(emojis: [String], numPairs: Int) -> MemoryGame<String> { // Can
        return MemoryGame<String>(numberOfPairsOfCards: numPairs) { pairIndex in
            emojis[pairIndex]
        }
        
    }
    
    func newGame() {
        themes.randomizeTheme()
        model = EmojiMemoryGame.createMemoryGame(emojis: themes.getEmojis()!, numPairs: themes.getNumPairs()!)
    }
    
    // MARK: - Access to Model
    
    var cards: Array<MemoryGame<String>.Card>{ // Computed variable
        return model.cards
    }
    
    var themeName: String {
        if let name = themes.getName() {
            return name
        }
        return ""
    }
    
    var score : String {
        return String(model.score)
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card){
        return model.choose(card: card)
    }
    
    
}
