//
//  BackCardViewController.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/15/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class BackCardViewController: UIViewController {
    
    @IBOutlet var displayImage: UIImageView!
    @IBOutlet var displayText: UILabel!
    let flipBackButton = UIButton()
    // var viewable : DukePerson
    let image : UIImage = currentPerson.img!
    let message : String = makeString(p: currentPerson)

    override func viewDidLoad() {
        
        displayImage.image = image
        displayImage.layer.cornerRadius = 75
        displayImage.contentMode = .scaleAspectFill
        
        displayText.text = message
        displayText.textAlignment = .center
        displayText.textColor = .textColor
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /*
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
        
        // Flip button
        
        flipBackButton.frame = CGRect(x:leftBorderX + 225, y: topStartingY + 10 * totalGapY, width: 75, height: blockHeight)
        flipBackButton.setTitle("Flip", for: UIControl.State())
        flipBackButton.setTitleColor(.buttonTextColor, for: UIControl.State())
        flipBackButton.backgroundColor = .buttonSliderColor
        flipBackButton.addTarget(self, action: #selector(flipBack), for: .touchUpInside)
        flipBackButton.layer.cornerRadius = 10
        view.addSubview(flipBackButton)
    }
    
    @objc func flipBack() {
        
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
