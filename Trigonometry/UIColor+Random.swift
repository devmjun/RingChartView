//
//  UIColor+Random.swift
//  Trigonometry
//
//  Created by MinjunJu on 19/11/2018.
//  Copyright © 2018 Minjun Ju. All rights reserved.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat(arc4random()) / CGFloat(UInt32.max),
            green: CGFloat(arc4random()) / CGFloat(UInt32.max),
            blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
            alpha: 1.0)
    }
}


