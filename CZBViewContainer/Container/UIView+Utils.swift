//
//  UIView+Utils.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import Foundation
import UIKit

public struct CornerRadii {
    var topLeft: CGFloat = 0
    var topRight: CGFloat = 0
    var bottomLeft: CGFloat = 0
    var bottomRight: CGFloat = 0
}

public extension UIView {
    func addCorner(cornnerRadii: CornerRadii) {
        let path = createPathWithRoundedRect(bounds: self.bounds, cornerRadii: cornnerRadii)
        let shapLayer = CAShapeLayer()
        shapLayer.frame = self.bounds
        shapLayer.path = path
        self.layer.mask = shapLayer        
    }
    
    func createPathWithRoundedRect(bounds: CGRect, cornerRadii: CornerRadii) -> CGPath {
        let mixX = bounds.minX
        let mixY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        let topLeftCenterX = mixX + cornerRadii.topLeft
        let topLeftCenterY = mixY + cornerRadii.topLeft
        
        let topRightCenterX = maxX - cornerRadii.topRight
        let topRightCenterY = mixY + cornerRadii.topRight
        
        let bottomLeftCenterX = mixX + cornerRadii.bottomLeft
        let bottomLeftCenterY = maxY - cornerRadii.bottomLeft
        
        let bottomRightCenterX = maxX - cornerRadii.bottomRight
        let bottomRightCenterY = maxY - cornerRadii.bottomRight
        
        let path :CGMutablePath = CGMutablePath();
         //顶 左
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornerRadii.topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        //顶右
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornerRadii.topRight, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: false)
        //底右
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornerRadii.bottomRight, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: false)
        //底左
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornerRadii.bottomLeft, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
        path.closeSubpath()
        return path
    }
}
