//
//  InformationViewController.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 2/7/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit
import SwiftUI

/*
 * Used for clear
 */

let emptyPerson = DukePerson(firstName: "", lastName: "", netID: "", email: "", whereFrom: "", gender: .Male, role: .Professor, degree: "Undergrad", hobbies: [], languages: [], team: "", image: UIImage(named: "blank_avatar.jpg")!)

/*
 * Starting values
 */

var isUpdate : Bool = false
var currentPerson = emptyPerson
var genderIndex = 0
var roleIndex = 0
var degreeIndex = 0
var hobbiesString = ""
var langString = ""
var text = ""
var image = UIImage(named: "blank_avatar.jpg")
var netID = ""

/*
 * UI Constants (some deprecated)
 */

let topStartingY = 75
let leftBorderX = 35
let rightStartingX = 35
let totalGapY = 40
let blockHeight = 32
let blockWidth = 300

/*
 * UI Objects
 */

let fNameTextBox = UITextField()
let lNameTextBox = UITextField()
let netIDTextBox = UITextField()
let emailLabel = UILabel()
let emailTextBox = UITextField()
let homeTextBox = UITextField()
let genderPicker = UISegmentedControl(items: [Gender.Male.rawValue, Gender.Female.rawValue, Gender.NonBinary.rawValue])
let rolePicker = UISegmentedControl(items: ["Professor", "TA", "Student", "Other"])
let degreePicker = UISegmentedControl(items: ["Undergrad", "Grad", "N/A"])
let hobbiesTextBox = UITextField()
let langTextBox = UITextField()
let teamTextBox = UITextField()

let addUpdateButton = UIButton()
let findButton = UIButton()
let clearButton = UIButton()
let resetButton = UIButton()
let enableButton = UIButton()
let flipButton = UIButton()
let out = UILabel()

let imageBox = UIImageView()
let imageButton = UIButton()

func allowEditing(b : Bool) {
    fNameTextBox.isEnabled = b
    lNameTextBox.isEnabled = b
    netIDTextBox.isEnabled = b
    emailTextBox.isEnabled = b
    homeTextBox.isEnabled = b
    genderPicker.isEnabled = b
    rolePicker.isEnabled = b
    degreePicker.isEnabled = b
    hobbiesTextBox.isEnabled = b
    langTextBox.isEnabled = b
    teamTextBox.isEnabled = b
    clearButton.isEnabled = b
    imageButton.isEnabled = b
    enableButton.isHidden = b
}

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, URLSessionDelegate {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard (info[.originalImage] as? UIImage) != nil else { return }
        
        let clicked : UIImage = info[.originalImage] as! UIImage
        let p = makePersonWithCurrent()
        p.img = clicked
        updatePerson(p: p)
        loadView()
        
        dismiss(animated: true)
    }
    
    func updateCodableAndrew(a : CodableDukePerson) -> Void {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        let encoder = JSONEncoder()
        let url = URL(string: uploadString)
        var request = URLRequest(url: url!)
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        print(String(data: try! encoder.encode(a), encoding: .utf8)!)
        let task = URLSession.shared.uploadTask(with: request, from: try! encoder.encode(a)) {
            (data, response, error) in
            if response != nil {
                print(response!)
            } else {
                print("Error")
            }
        }
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Make decisions based on what button is selected, save, cancel, etc
        
        if let s = sender as? UIButton {
            if s == flipButton {
                return
            }
        }
        
        allowEditing(b: true)
        let c = currentPerson
        let p = makePersonWithCurrent()
        updatePerson(p: emptyPerson)
        
        if ((sender as! UIBarButtonItem) != self.saveButton) {
            return
        }
        
        if p.firstName == "Andrew" && p.lastName == "Krier" {
            updateCodableAndrew(a: CodableDukePerson.make(p))
        }
        
        if isUpdate {
            print("Previous: \(c.firstName) \(c.lastName)")
            print("Updated: \(p.firstName) \(p.lastName)")
            
            DataBase.update(previous: c, updated: p)
            return
        }
        
        DataBase.add(dp: p)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        
        // First name, text box
        
        fNameTextBox.textAlignment = .center
        fNameTextBox.frame = CGRect(x:rightStartingX, y: topStartingY, width: blockWidth/2, height: blockHeight)
        fNameTextBox.text = currentPerson.firstName
        fNameTextBox.textColor = .textColor
        
        // placeholder code from https://stackoverflow.com/questions/1340224/iphone-uitextfield-change-placeholder-text-color
        
        fNameTextBox.attributedPlaceholder =
            NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        
        view.addSubview(fNameTextBox)
        
        // Last name, text box
        
        lNameTextBox.textAlignment = .center
        lNameTextBox.frame = CGRect(x:rightStartingX + blockWidth/2, y: topStartingY /*+ totalGapY*/, width: blockWidth/2, height: blockHeight)
        lNameTextBox.text = currentPerson.lastName
        lNameTextBox.textColor = .textColor
        lNameTextBox.attributedPlaceholder =
            NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(lNameTextBox)
        
        // netID, text box
        
        netIDTextBox.textAlignment = .center
        netIDTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + totalGapY, width: blockWidth/2, height:blockHeight)
        netIDTextBox.text = currentPerson.netID
        netIDTextBox.textColor = .textColor
        netIDTextBox.attributedPlaceholder =
            NSAttributedString(string: "netID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(netIDTextBox)
        
        // Email, text box
        
        emailTextBox.textAlignment = .center
        emailTextBox.frame = CGRect(x:rightStartingX + blockWidth/2, y: topStartingY + totalGapY, width: blockWidth/2, height: blockHeight)
        emailTextBox.text = currentPerson.email
        emailTextBox.textColor = .textColor
        emailTextBox.attributedPlaceholder =
            NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(emailTextBox)
        
        // Home, text box
        
        homeTextBox.textAlignment = .center
        homeTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 2 * totalGapY, width: blockWidth, height: blockHeight)
        homeTextBox.text = currentPerson.whereFrom
        homeTextBox.textColor = .textColor
        homeTextBox.attributedPlaceholder =
            NSAttributedString(string: "City, State", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(homeTextBox)
        
        // Gender, picker
        
        genderPicker.tintColor = .buttonSliderColor
        genderPicker.selectedSegmentTintColor = .sliderColor
        genderPicker.frame = CGRect(x:rightStartingX, y: topStartingY + 3 * totalGapY, width: blockWidth, height: blockHeight)
        genderPicker.backgroundColor = .lightGray
        genderPicker.selectedSegmentIndex = genderIndex
        view.addSubview(genderPicker)
        
        // Role, picker
        
        rolePicker.selectedSegmentTintColor = .sliderColor
        rolePicker.frame = CGRect(x:rightStartingX, y: topStartingY + 4 * totalGapY, width: blockWidth, height: blockHeight)
        rolePicker.backgroundColor = .lightGray
        rolePicker.selectedSegmentIndex = roleIndex
        view.addSubview(rolePicker)
        
        // Degree, picker
        
        degreePicker.selectedSegmentTintColor = .sliderColor
        degreePicker.frame = CGRect(x:rightStartingX, y: topStartingY + 5 * totalGapY, width: blockWidth, height: blockHeight)
        degreePicker.backgroundColor = .lightGray
        degreePicker.selectedSegmentIndex = degreeIndex
        view.addSubview(degreePicker)
        
        // Hobbies, textbox
        
        hobbiesTextBox.textAlignment = .center
        hobbiesTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 6 * totalGapY, width: blockWidth, height: blockHeight)
        hobbiesTextBox.text = hobbiesString
        hobbiesTextBox.textColor = .textColor
        hobbiesTextBox.attributedPlaceholder =
            NSAttributedString(string: "Hobbies: Running, etc", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(hobbiesTextBox)
        
        // Languages, text box
        
        langTextBox.textAlignment = .center
        langTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 7 * totalGapY, width: blockWidth, height: blockHeight)
        langTextBox.text = langString
        langTextBox.textColor = .textColor
        langTextBox.attributedPlaceholder =
            NSAttributedString(string: "Languages: Swift, etc", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(langTextBox)
        
        // Team, textbox
        
        teamTextBox.textAlignment = .center
        teamTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 8 * totalGapY, width: blockWidth, height: blockHeight)
        teamTextBox.text = currentPerson.team
        teamTextBox.textColor = .textColor
        teamTextBox.attributedPlaceholder =
            NSAttributedString(string: "Team", attributes: [NSAttributedString.Key.foregroundColor: UIColor.attributeColor])
        view.addSubview(teamTextBox)
        
        // Clear button
        
        clearButton.frame = CGRect(x:leftBorderX + 125, y: topStartingY + 9 * totalGapY, width: 175, height: blockHeight)
        clearButton.setTitle("Clear", for: UIControl.State())
        clearButton.setTitleColor(.buttonTextColor, for: UIControl.State())
        clearButton.backgroundColor = .buttonSliderColor
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        clearButton.layer.cornerRadius = 10
        view.addSubview(clearButton)
        
        // Enable button
        
        enableButton.frame = CGRect(x:leftBorderX + 125, y: topStartingY + 10 * totalGapY, width: 75, height: blockHeight)
        enableButton.setTitle("Edit", for: UIControl.State())
        enableButton.setTitleColor(.buttonTextColor, for: UIControl.State())
        enableButton.backgroundColor = .buttonSliderColor
        enableButton.addTarget(self, action: #selector(enable), for: .touchUpInside)
        enableButton.layer.cornerRadius = 10
        view.addSubview(enableButton)
        
        // Flip button
        
        flipButton.frame = CGRect(x:leftBorderX + 225, y: topStartingY + 10 * totalGapY, width: 75, height: blockHeight)
        flipButton.setTitle("Flip", for: UIControl.State())
        flipButton.setTitleColor(.buttonTextColor, for: UIControl.State())
        flipButton.backgroundColor = .buttonSliderColor
        flipButton.addTarget(self, action: #selector(flip), for: .touchUpInside)
        flipButton.layer.cornerRadius = 10
        view.addSubview(flipButton)
        
        // Bottom text box
        
        out.textAlignment = .center
        out.frame = CGRect(x:leftBorderX, y: topStartingY + 11 * totalGapY, width: 300, height: blockHeight * 4)
        out.text = text
        out.textColor = .textColor
        out.backgroundColor = .backgroundColor
        out.lineBreakMode = .byWordWrapping
        out.numberOfLines = 0
        view.addSubview(out)
        
        imageButton.frame = CGRect(x: leftBorderX, y: topStartingY + 9 * totalGapY, width: totalGapY + blockHeight, height: totalGapY + blockHeight)
        imageButton.setImage(image, for: UIControl.State())
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.addTarget(self, action: #selector(imageClick), for: .touchUpInside)
        view.addSubview(imageButton)
        
        self.view = view
    
    }
    
    @objc func clear() {
        updatePerson(p: emptyPerson)
        text = ""
        loadView()
    }
    
    @objc func enable() {
        allowEditing(b: true)
    }
    
    @objc func imageClick() {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func flip() {
        if(currentPerson.firstName == "Andrew" && currentPerson.lastName == "Krier") {
            performSegue(withIdentifier: "flipViewControllerAndrew", sender: flipButton)
            return
        }
        
        performSegue(withIdentifier: "flipViewController", sender: flipButton)
        //print("flip")
    }
    
    @IBAction func returnFromFlip(segue: UIStoryboardSegue) {}

}
