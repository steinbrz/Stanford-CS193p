//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 9/8/21.
//

import Foundation

class SetGameViewModel : ObservableObject {
    
    typealias Card = GameModel.Card
    
    @Published private var model = createGameModel()
    
    private static func createGameModel() -> GameModel {
        GameModel()
    }
    
    
    // MARK: - Access To Model
    func cards() -> [Card] {
        model.dealtCards
    }
    
    func haveSet() -> Bool {
        return model.haveSet
    }
    
    // MARK: - Intents
    
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func dealCards() {
        model.dealCards()
    }
    
    func newGame() {
        model = SetGameViewModel.createGameModel()
    }
    
    
    
}
