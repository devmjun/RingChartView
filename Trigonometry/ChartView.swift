//
//  FourplaneView.swift
//  Trigonometry
//
//  Created by Minjun Ju on 18/11/2018.
//  Copyright © 2018 Minjun Ju. All rights reserved.
//

import UIKit

enum ColorDataType {
    case dataAndColor(data: Double, color: UIColor)
}

open class RingChartView: UIView {
    private var renderer: RingChartViewRenderer
    var data: [ColorDataType] {
        didSet {
            setNeedsDisplay()
        }
    }
    var attributes: [NSAttributedString.Key:Any] {
        didSet {
            renderer.attributes = self.attributes
            setNeedsDisplay()
        }
    }
    
    init(frame: CGRect, data: [ColorDataType]) {
        self.data = data
        renderer = RingChartViewRenderer(rect: frame)
        attributes = renderer.attributes
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func draw(_ rect: CGRect) {
        renderer.setChart(data: data)
    }
}

private class RingChartViewRenderer {
    var rect: CGRect
    var centerX: CGFloat
    var centerY: CGFloat
    var center: CGPoint
    var radius: CGFloat
    var attributes: [NSAttributedString.Key: Any]
    
    init(rect: CGRect) {
        self.rect = rect
        radius = min(rect.width/2, rect.height/2)
        centerX = rect.midX - rect.minX
        centerY = rect.midY - rect.minY
        center = CGPoint(x: centerX, y: centerY)
        attributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).withSize(radius*0.1),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    
    func setChart(data: [ColorDataType]) {
        let copyData = data
            .compactMap { data -> Double? in
            guard case .dataAndColor(let element, _) = data else { return nil }
                return element
        }
        
        let copyColors = data
            .compactMap { data -> UIColor? in
                guard case .dataAndColor(_, let color) = data else { return nil }
                return color
        }
        
        let total = copyData.reduce(0, +)
        let information = copyData
            .map { $0 / total }
            .map { $0 * 360 }
            .map { $0.degreesToRadians }
            .map { CGFloat($0) }
            .sorted { $0 < $1 }
        
        (0..<information.count)
            .forEach { [weak self] (index: Int) in
                guard let self = self else { return }
                
                let trimedInformation = information[0...index]
                let endAngle = trimedInformation.reduce(0, +)
                let startAngle = endAngle - information[index]
                
                let piecePath = UIBezierPath(
                    arcCenter: self.center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true)
                
                piecePath.addLine(to: self.center)
                piecePath.close()
                copyColors[index].setFill()
                piecePath.fill()
                
                let centerOfArc: CGPoint = {
                    let angleRange = endAngle - startAngle
                    let centerAngle = angleRange / 2 + startAngle
                    let arcCenterX = self.centerX + cos(centerAngle) * radius / 2
                    let arcCenterY = self.centerY + sin(centerAngle) * radius / 2
                    return CGPoint(x: arcCenterX, y: arcCenterY)
                }()
                
                let precent = copyData
                    .map { $0 / total * 100 }
                    .map { Int($0.rounded()) }
                
                let percentStr = "\(precent[index])%" as NSString
                percentStr.draw(
                    with: CGRect(
                        origin: centerOfArc,
                        size: CGSize(width: radius, height: 36)),
                    options: .usesDeviceMetrics,
                    attributes: self.attributes,
                    context: nil)
        }
    }
}

