//
//  Cone.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/22/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class Cone: UIView {

    override func draw(_ rect: CGRect) {
        
        let base = UIBezierPath(roundedRect: CGRect(x: rect.minX, y: rect.minY + 2 * rect.height / 3, width: rect.width, height: rect.height/3), cornerRadius: rect.height/10)
        
        UIColor.black.setStroke()
        base.lineWidth = 4
        UIColor.orange.setFill()
        base.fill()
        base.stroke()
        
        
        let cone = UIBezierPath()
        cone.move(to: CGPoint(x: rect.minX + rect.width / 4, y: rect.maxY - rect.height / 5))
        cone.addLine(to: CGPoint(x: rect.minX + 5 * rect.width / 12, y: rect.minY))
        cone.addLine(to: CGPoint(x: rect.minX + 7 * rect.width / 12, y: rect.minY))
        cone.addLine(to: CGPoint(x: rect.minX + 3 * rect.width / 4, y: rect.maxY - rect.height / 5))
        cone.close()
        
        UIColor.black.setStroke()
        cone.lineWidth = 4
        UIColor.orange.setFill()
        cone.fill()
        cone.stroke()
    }

}
