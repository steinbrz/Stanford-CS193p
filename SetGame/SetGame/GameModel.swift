//
//  GameModel.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 9/8/21.
//


import SwiftUI

struct GameModel {
    private var deck: [Card]
    
    private(set) var dealtCards: [Card]
    
    private var numDealtCards : Int = 12 // Is this the appropriate place to put the default?
    
    // Computed Var to know if we have a matching set
    
    var haveSet: Bool {
        get {
            let selectedCards = dealtCards.indices.filter { dealtCards[$0].isSelected == true }
            
            if selectedCards.count != 3 {
                return false
            }
            
            // Check each feature has all the same or all different for 3 cards
            for feature in 0..<4 {
                if !checkFeature(cardIndices: selectedCards, feature: feature) {
                    return false
                }
            }
            
            return true
        }
    }
    
    //Compute Variable to return array of indices for cards that have been selected
    var selectedCards: [Int] {
        get {
            return dealtCards.indices.filter {dealtCards[$0].isSelected == true }
        }
    }
    
    mutating func replaceSet() {
        for idx in selectedCards {
            
            // If there are cards left in the deck, replace the selected cards with them
            // Else, remove cards from dealtCards so spots are filled in my remaining cards
            if deck.count > 0 {
                dealtCards[idx] = deck.removeFirst()
            } else {
                dealtCards.remove(at: idx)
            }
        }
    }
    
    
    
    // Implements functionality when selecting a card in the game
    mutating func choose(_ card: Card) {
        // Check if we have 3 cards
        
        if let chosenIndex = dealtCards.firstIndex(where: {$0.id == card.id}) {
            if haveSet {
                // Toggle is selected for chosen card
                // Then replace matching set with 3 new cards
                // If chosen card was part of set, it will not be highlighted since it gets removed by replaceSet()
                dealtCards[chosenIndex].isSelected.toggle()
                replaceSet()
            } else {
                // Check if we have non matching set
                if selectedCards.count == 3 {
                    deselectCards()
                }
                dealtCards[chosenIndex].isSelected.toggle()
            }
        }
    }
    
    
//     Function to deselect all selected cards
    mutating func deselectCards() {
        let selectedCards = dealtCards.indices.filter { dealtCards[$0].isSelected == true }
        for idx in selectedCards {
            dealtCards[idx].isSelected = false
        }
    }
    
    func checkFeature(cardIndices: [Int], feature: Int) -> Bool {

        var matchSet : Set<SetCases> = []
        // Check first feature
        for idx in cardIndices {
            matchSet.insert(dealtCards[idx].features[feature])
        }
        
        if matchSet.count == 2{
            // Not a match, needs to be either 1 or 3(all same or all different)
            return false
        }
        
        return true
    }
    
    mutating func dealCards() {
        // If deck still has cards
        // Replace matching set
        // Or add 3 new cards
        
        if deck.count > 0 {
            if haveSet {
                replaceSet()
            } else {
                for _ in 0..<3 {
                    dealtCards.append(deck.removeFirst())
                }
            }
            
        }
    }

    
    // Init all of the possible card options
    init() {
        var id = 0
        deck = []
        dealtCards = []
        
        for feature1 in SetCases.allCases {
            for feature2 in SetCases.allCases {
                for feature3 in SetCases.allCases {
                    for feature4 in SetCases.allCases {
                        let cardFeatures = [feature1, feature2, feature3, feature4]
                        let card = Card(features: cardFeatures, id: id)
                        deck.append(card)
                        id += 1
                    }
                }
            }
        }
        
        deck.shuffle()
        
        // Deal first 12 cards
        for _ in 0..<numDealtCards {
            dealtCards.append(deck.removeFirst())
        }
        
        
    }
    
    
    struct Card: Identifiable {
        var isSelected = false
        var isMatched = false
        let features: [SetCases]
        let id: Int
        
    }

}
