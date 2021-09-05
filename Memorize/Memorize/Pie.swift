//
//  Pie.swift
//  Memorize
//
//  Created by Zachary Steinbrenner on 9/5/21.
//

import SwiftUI

struct Pie: Shape {
    
    // 0 degrees is to the right
    // 90 degrees is down and so on...
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 // Divide by two to get radius from diameter
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise // Down on the y axis is positive when drawing Path(). This makes clockwise upside down compared to traditional understanding
        )
        
        p.addLine(to: center)
        
        
        
        return p
    }
    
    
}
