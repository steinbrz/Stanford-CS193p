//
//  Diamond.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 10/7/21.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
//        let center = CGPoint(x: rect.midX, y: rect.midY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        
        var p = Path()
        
        p.move(to: left)
        p.addLine(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        
        return p
    }
}
