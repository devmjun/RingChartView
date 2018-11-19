//
//  Convert+DegressOrRadius.swift
//  Trigonometry
//
//  Created by MinjunJu on 19/11/2018.
//  Copyright © 2018 Minjun Ju. All rights reserved.
//

import UIKit

extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

