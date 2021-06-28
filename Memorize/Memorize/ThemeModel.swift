//
//  Theme.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 6/27/21.
//

import Foundation

struct ThemeModel {
    private var themeArray: [Theme]
    private var themeNum: Int?
    
    init() {
        themeArray = [Theme]()
        themeArray.append(Theme(name: "Cars", color: "red", emojis: ["🚗", "🚙", "🚕", "🚓", "🏎", "🛻", "🚚", "🚛"], numPairs: 5)) // less pairs then emojis
        themeArray.append(Theme(name: "Faces", color: "blue", emojis: ["😇", "😍", "🤪", "🥸", "🤩", "🥺", "🤯", "🤥", "🙄"], numPairs: 10)) // 1 more pair then their are emojis
        themeArray.append(Theme(name: "Flags", color: "green", emojis: ["🏳️‍🌈", "🇧🇪", "🇦🇺", "🏴‍☠️", "🏁", "🇺🇸", "🇬🇧", "🇰🇷", "🇬🇷", "🚩", "🏳️"], numPairs: 11)) // Same num pairs as emojis
        themeArray.append(Theme(name: "Objects", color: "yellow", emojis: ["💿", "📞", "☎️", "📻", "🕰", "💰", "🪚", "⚔️", "🛡", "💊", "🌡", "📎", "📭", "📦", "🛏", "📐", "📌", "✂️"], numPairs: 11))
        themeArray.append(Theme(name: "Food", color: "orange", emojis: ["🌶", "🍎", "🍌", "🍅", "🥦", "🥨", "🥓", "🍕", "🍟", "🍔", "🌭", "🥩", "🍙", "🍜", "🍤", "🍿"], numPairs: 15))
        themeArray.append(Theme(name: "Sports", color: "purple", emojis: ["⚽️", "🎱", "🪃", "🏈", "🏉", "⛳️", "🛹", "🥏", "🏸", "🥊", "🏄‍♂️"], numPairs: 11))
        themeNum = Int.random(in: 0..<themeArray.count)
    }
    
    
    mutating func addTheme(name: String, color: String, emojis: [String], numPairs: Int){
        let newTheme = Theme(name: name, color: color, emojis: emojis, numPairs: numPairs)
        themeArray.append(newTheme)
        themeNum = Int.random(in: 0..<themeArray.count)
    }
    
    func getEmojis() -> [String]? {
        if let idx = themeNum {
            return themeArray[idx].emojis.shuffled() // Returns random 
        }
        return nil
    }
    
    func getNumPairs() -> Int? {
        if let idx = themeNum {
            return (themeArray[idx].numPairs < themeArray[idx].emojis.count) ? themeArray[idx].numPairs : themeArray[idx].emojis.count
        }
        return nil
    }
    
    mutating func randomizeTheme() {
        themeNum = Int.random(in: 0..<themeArray.count)
    }
    
    func getName() -> String? {
        if let idx = themeNum {
            return themeArray[idx].name
        }
        return nil
    }
    struct Theme {
        var name: String
        var color: String
        var emojis: [String]
        var numPairs: Int
    }
    
    
}
