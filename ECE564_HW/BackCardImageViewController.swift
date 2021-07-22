//
//  BackCardImageViewController.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/20/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class BackCardImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        addFrisbee()
        addGrass()
        addCone()
        addText()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func addText() {
        
        let text = "It's a great day for frisbee"
        let font = UIFont(name: "AmericanTypewriter", size: 25.0)
        
        let att = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        let attString = NSAttributedString(string: text, attributes: (att) as [NSAttributedString.Key : Any])
        
        //attString.draw(at: CGPoint(x: 25, y: 600))
        
        let tf = UITextView()
        tf.textAlignment = .center
        tf.backgroundColor = .grassGreen
        tf.attributedText = attString
        tf.frame = CGRect(x: 25, y: 575, width: 325, height: 75)
        
        view?.addSubview(tf)
        
    }
    
    func addFrisbee() {
        
        //print("got to frisbee")
        
        let fris = UIImageView()
        fris.frame = CGRect(x: 63, y: 350, width: 250, height: 100)
        
        let i1 = UIImage(named: "Frisbee1.png")!
        let i2 = UIImage(named: "Frisbee2.png")!
        let i3 = UIImage(named: "Frisbee3.png")!
        let i4 = UIImage(named: "Frisbee4.png")!
        let i5 = UIImage(named: "Frisbee5.png")!
        let i6 = UIImage(named: "Frisbee6.png")!
        
        fris.contentMode = .scaleToFill
        fris.animationImages = [i1, i2, i3, i4, i5, i6]
        fris.animationDuration = 0.25
        fris.startAnimating()
        
        view?.addSubview(fris)
    }
    
    func addCone() {
        let cframe = CGRect(x: -100, y: 250, width: 50, height: 75)
        let c = Cone()
        c.frame = cframe
        c.backgroundColor = .grassGreen
        view?.addSubview(c)
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        c.frame.origin.x += 600
        })
    }
    
    func addGrass() {
        let g1frame = CGRect(x: 50, y: 250, width: 50, height: 15)
        let g1 = GrassLines()
        g1.frame = g1frame
        g1.backgroundColor = .grassGreen
        view?.addSubview(g1)
        
        let g2frame = CGRect(x: 275, y: 500, width: 50, height: 15)
        let g2 = GrassLines()
        g2.frame = g2frame
        g2.backgroundColor = .grassGreen
        view?.addSubview(g2)
        
        let g3frame = CGRect(x: 75, y: 550, width: 50, height: 15)
        let g3 = GrassLines()
        g3.frame = g3frame
        g3.backgroundColor = .grassGreen
        view?.addSubview(g3)
        
        let g4frame = CGRect(x: 315, y: 300, width: 50, height: 15)
        let g4 = GrassLines()
        g4.frame = g4frame
        g4.backgroundColor = .grassGreen
        view?.addSubview(g4)
        
        let g11frame = CGRect(x: -550, y: 250, width: 50, height: 15)
        let g11 = GrassLines()
        g11.frame = g11frame
        g11.backgroundColor = .grassGreen
        view?.addSubview(g11)
        
        let g21frame = CGRect(x: -325, y: 500, width: 50, height: 15)
        let g21 = GrassLines()
        g21.frame = g21frame
        g21.backgroundColor = .grassGreen
        view?.addSubview(g21)
        
        let g31frame = CGRect(x: -525, y: 550, width: 50, height: 15)
        let g31 = GrassLines()
        g31.frame = g31frame
        g31.backgroundColor = .grassGreen
        view?.addSubview(g31)
        
        let g41frame = CGRect(x: -285, y: 300, width: 50, height: 15)
        let g41 = GrassLines()
        g41.frame = g41frame
        g41.backgroundColor = .grassGreen
        view?.addSubview(g41)
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g1.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g2.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g3.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g4.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g11.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g21.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g31.frame.origin.x += 600
        })
        
        UIView.animate(withDuration: 7, delay: 1,
                       options: [.repeat, .curveLinear], animations: {
                        g41.frame.origin.x += 600
        })
    }
    
    func setBackground() {
        let bgFrame = CGRect(x: 0, y: 0, width: 375, height: 667)
        
        UIGraphicsBeginImageContextWithOptions(bgFrame.size, false, 0.0)
        
        // Sky
        
        let bpath : UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 375, height: 200))
        let color : UIColor = .skyBlue
        color.set()
        bpath.fill()
        bpath.stroke()

        // Grass

        let bpath2:UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 200, width: 375, height: 467))
        let color2:UIColor = .grassGreen
        color2.set()
        bpath2.fill()
        bpath2.stroke()
        
        // Clouds?
        
        let cpath1 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 30, height: 30))
        let ccolor : UIColor = .white
        ccolor.set()
        cpath1.fill()
        cpath1.stroke()
        
        let cpath2 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 115, y: 85, width: 30, height: 30))
        ccolor.set()
        cpath2.fill()
        cpath2.stroke()
        
        let cpath3 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 115, y: 115, width: 30, height: 30))
        ccolor.set()
        cpath3.fill()
        cpath3.stroke()
        
        let cpath4 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 115, y: 100, width: 30, height: 30))
        ccolor.set()
        cpath4.fill()
        cpath4.stroke()
        
        let cpath5 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 130, y: 100, width: 30, height: 30))
        ccolor.set()
        cpath5.fill()
        cpath5.stroke()
        
        let cpath6 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 140, y: 80, width: 30, height: 30))
        ccolor.set()
        cpath6.fill()
        cpath6.stroke()
        
        let cpath7 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 155, y: 90, width: 30, height: 30))
        ccolor.set()
        cpath7.fill()
        cpath7.stroke()
        
        let cpath8 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 150, y: 110, width: 30, height: 30))
        ccolor.set()
        cpath8.fill()
        cpath8.stroke()
        
        let cpath9 : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 135, y: 110, width: 30, height: 30))
        ccolor.set()
        cpath9.fill()
        cpath9.stroke()
        
        
        let saveImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let iv = UIImageView()
        iv.frame = bgFrame
        iv.image = saveImage
        view?.addSubview(iv)
    }

}
