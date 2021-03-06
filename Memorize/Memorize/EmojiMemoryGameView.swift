//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 4/29/21.
//

import SwiftUI

struct EmojiMemoryGameView : View {
    
    @ObservedObject var game: EmojiMemoryGame // @ObservedObject will rebuild body of ContentView. Only rebuilds views that have changed
    
    
    var body: some View {
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    
}


struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        
        GeometryReader(content: { geometry in
                ZStack {
                    let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius) // Rounded rectangle uses all the space provided to it. This means z stack uses all the space
                    if card.isFaceUp {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                            .padding(DrawingConstants.circlePadding)
                            .opacity(DrawingConstants.circleOpacity)
                        Text(card.content).font(font(in: geometry.size))
                    } else if card.isMatched {
                        shape.opacity(0) // Makes it transparent
                    } else {
                        shape.fill()
                    }
                }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
        static let circlePadding: CGFloat = 5
        static let circleOpacity: Double = 0.5
        
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
//        Group {
//            EmojiMemoryGameView(game: game)
//                .preferredColorScheme(.light)
//            EmojiMemoryGameView(game: game)
//                .preferredColorScheme(.dark)
//        }
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
