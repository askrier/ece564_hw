//
//  GrassLines.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/22/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class GrassLines: UIView {
    
    /*
     * https://www.appcoda.com/bezier-paths-introduction/
     */
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX + rect.width/8, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + rect.width/3, y: rect.maxY - rect.height/5))
        path.addLine(to: CGPoint(x: rect.minX + rect.width/2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + 2*rect.width/3, y: rect.maxY - rect.height/5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width/8, y: rect.maxY))
        
        UIColor.black.setStroke()
        path.lineWidth = 2
        
        path.stroke()

    }

}
