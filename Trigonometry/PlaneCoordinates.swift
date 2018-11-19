//
//  PlaneCoordinates.swift
//  Trigonometry
//
//  Created by MinjunJu on 19/11/2018.
//  Copyright © 2018 Minjun Ju. All rights reserved.
//

import UIKit

@IBDesignable
class PlaneCoordinates: CALayer {
    private var coordinatePlane = UIBezierPath()
    private let pliotPath = UIBezierPath()
    
    var lineColor = UIColor.black.withAlphaComponent(0.2).cgColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var length: CGFloat = 9 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(bounds: CGRect) {
        super.init()
        frame = bounds
        setNeedsDisplay()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        // vertical line
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let centerX = center.x
        let centerY = center.y
        
        coordinatePlane.move(to: CGPoint(x: center.x, y: 0))
        coordinatePlane.addLine(to: CGPoint(x: center.x,y: bounds.height))
        
        // horizontal line
        coordinatePlane.move(to: CGPoint(x: 0, y: center.y))
        coordinatePlane.addLine(to: CGPoint(x: bounds.width,y: center.y))
        
        // line
        let range = { (n: Int) in
            return 0...(n / 10)
        }
        
        range(Int(centerX))
            .compactMap { center.x + CGFloat($0) * 10 }
            .forEach {
                pliotPath.move(to: CGPoint(x: $0, y: centerY - length/2))
                pliotPath.addLine(to: CGPoint(x: $0, y: centerY + length/2))
                pliotPath.move(to: CGPoint(x: $0 - centerX, y: centerY - length/2))
                pliotPath.addLine(to: CGPoint(x: $0 - centerX, y: centerY + length/2))
        }
        range(Int(centerY))
            .compactMap{ centerY + CGFloat($0) * 10 }
            .forEach {
                pliotPath.move(to: CGPoint(x: centerX - length/2, y: $0))
                pliotPath.addLine(to: CGPoint(x: centerX + length/2, y: $0))
                pliotPath.move(to: CGPoint(x: centerX - length/2, y: $0 - centerY ))
                pliotPath.addLine(to: CGPoint(x: centerX + length/2, y: $0 - centerY))
        }
        
        ctx.addPath(coordinatePlane.cgPath)
        ctx.addPath(pliotPath.cgPath)
        ctx.setStrokeColor(lineColor)
        ctx.strokePath()
    }
}
