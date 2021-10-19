//
//  SetGameApp.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 9/8/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    private let game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            GameView(game: game)
        }
    }
}
