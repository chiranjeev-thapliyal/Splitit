//
//  BottomRoundedRectangle.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 30/04/24.
//

import SwiftUI

struct BottomRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height
        let tr = CGPoint(x: rect.maxX, y: rect.minY) // Top right corner
        let br = CGPoint(x: rect.maxX, y: rect.maxY) // Bottom right corner
        let bl = CGPoint(x: rect.minX, y: rect.maxY) // Bottom left corner
        let tl = CGPoint(x: rect.minX, y: rect.minY) // Top left corner

        path.move(to: tl)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + height - radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + height - radius), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY + height))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + height - radius), radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
        path.addLine(to: tr)
        path.addLine(to: tl)

        return path
    }
}
