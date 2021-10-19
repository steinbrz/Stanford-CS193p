//
//  SetGameView.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 9/8/21.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.cards(), aspectRatio: 2/3) { card in
                CardView(card: card, haveSet: game.haveSet())
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                
            }
            
            Spacer()
            
            HStack {
                newGameButton
                Spacer()
                Text("Deal").font(.largeTitle)
            }
            .padding()
            .foregroundColor(.red)
        }
    
    }
    
    var newGameButton = Button (action: {
        game.newGame()
    }, label: {
        Text("New Game").font(.largeTitle)
    })
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        return GameView(game: game)
    }
}
