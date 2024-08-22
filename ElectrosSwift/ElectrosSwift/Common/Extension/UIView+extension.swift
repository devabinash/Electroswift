//
//  UIView+extension.swift
//  ElectronicsStoreSwift
//
//  Created by Pinto Junior, William James on 21/07/22.
//

import UIKit

extension UIView {
    func makeDashedBorderLine() {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = [4, 6]
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height/2),
                                CGPoint(x: bounds.maxX, y: bounds.height/2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
