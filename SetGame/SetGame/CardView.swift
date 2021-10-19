//
//  CardView.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 9/8/21.
//

import SwiftUI

struct CardView: View {
    
    let card: SetGameViewModel.Card
    let haveSet: Bool
    // feature[1] is number of cards
    // feature[2] is color
    // feature[3] is shading
    // feature[4] is shape
    
    var body: some View {
        ZStack {
            
            // Use red border to highlight if card has been selected and if its a matched
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
            
            // Use border colors to indicate selection and if we have a set
            if card.isSelected {
                if haveSet {
                    shape.foregroundColor(.green)
                } else {
                    shape.foregroundColor(.blue)
                }
            } else {
                shape
            }
            
            
            // Shapes on card rendered here
            VStack {
                ForEach(0..<card.features[0].rawValue, id: \.self) { i in
                    symbol
                }
            } .padding()
            
            
        }
    }
    
    
    @ViewBuilder var symbol : some View {
        
        if card.features[1] == .first {
            symbolShaded.foregroundColor(.red)
        } else if card.features[1] == .second {
            symbolShaded.foregroundColor(.purple)
        } else {
            symbolShaded.foregroundColor(.green)
        }

        
    }
        
    @ViewBuilder var symbolShaded: some View {
        if card.features[2] == .first {
            filledSymbol
        } else if card.features[2] == .second {
            strokedSymbol
        } else {
            shadedSymbol
        }
    }
    
    @ViewBuilder var strokedSymbol : some View {
        if card.features[3] == .first {
            Rectangle()
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                .aspectRatio(2, contentMode: .fit)
        } else if card.features[3] == .second {
            Ellipse()
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                .aspectRatio(2, contentMode: .fit)
        } else {
            Diamond()
                .stroke(lineWidth: DrawingConstants.lineWidth)
                .aspectRatio(2, contentMode: .fit)
        }
    }

    @ViewBuilder var filledSymbol : some View {
        if card.features[3] == .first {
            Rectangle()
                .fill()
                .aspectRatio(2, contentMode: .fit)
        } else if card.features[3] == .second {
            Ellipse()
                .fill()
                .aspectRatio(2, contentMode: .fit)
        } else {
            Diamond()
                .fill()
                .aspectRatio(2, contentMode: .fit)
        }
    }
    
    @ViewBuilder var shadedSymbol : some View {
        if card.features[3] == .first {
            Rectangle()
                .fillAndStrokeBorder(lineWidth: DrawingConstants.lineWidth)
                .aspectRatio(2, contentMode: .fit)
        } else if card.features[3] == .second {
            Ellipse()
                .fillAndStrokeBorder(lineWidth: DrawingConstants.lineWidth)
                .aspectRatio(2, contentMode: .fit)
        } else {
            Diamond()
                .fillAndStroke(lineWidth: DrawingConstants.lineWidth)
                .aspectRatio(2, contentMode: .fit)
        }
    }
}


extension Shape {
    
    func fillAndStroke(lineWidth: CGFloat) -> some View {
        self
            .stroke(lineWidth: lineWidth)
            .background(self.fill().opacity(0.4))
    }
}

extension InsettableShape {
    
    
    func fillAndStrokeBorder(lineWidth: CGFloat) -> some View {
        
        self
            .strokeBorder(lineWidth: lineWidth)
            .background(self.fill().opacity(0.4))
    }
}





