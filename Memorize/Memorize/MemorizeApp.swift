//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 4/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
