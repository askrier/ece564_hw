//: This is the playground file to use for submitting HW1.  You will add your code where noted below.  Make sure you only put the code required at load time in the ``loadView()`` method.  Other code should be set up as additional methods (such as the code called when a button is pressed).
  
import UIKit
import PlaygroundSupport

enum Gender : String {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Other = "Other"
}

protocol ECE564 {
    var degree : String { get }
    var languages: [String] { get }
    var team : String { get }
}

// You can add code here

/*
 * Data Structure
 */

class DukePerson: Person, CustomStringConvertible, ECE564 {
    
    var description: String {
        return "\(firstName) \(lastName) \(degree)"
    }
    
    var degree: String = ""
    
    var languages: [String] = [""]
    
    var team: String = ""
    
    var role: DukeRole = .Student
    
    init(firstName: String, lastName: String) {
        super.init()
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(firstName: String, lastName: String, whereFrom: String, gender: Gender, role: DukeRole, degree: String, hobbies: [String], languages: [String], team: String) {
        
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
        self.role = role
        self.degree = degree
        self.hobbies = hobbies
        self.languages = languages
        self.team = team
    }
    
}



/*
 * "Database"
 */

var people: [DukePerson] = []
var kaidi = DukePerson(firstName: "Kaidi", lastName: "Lyu", whereFrom: "China", gender: .Female, role: .TA, degree: "Grad", hobbies: ["Hiking", "Swimming", "Biking"], languages: ["Swift", "Java", "C++"], team: "None")
var ananjaya = DukePerson(firstName: "Ananjaya", lastName: "Tyagi", whereFrom: "India", gender: .Female, role: .TA, degree: "Grad", hobbies: ["Reading", "Watching Movies"], languages: ["Java", "Swift", "Python"], team: "None")
var ric = DukePerson(firstName: "Richard", lastName: "Telford", whereFrom: "Chatham County, NC", gender: .Male, role: .Professor, degree: "N/A", hobbies: ["Swimming", "Reading", "Golf"], languages: ["Swift", "C", "C++"], team: "None")
var andrew = DukePerson(firstName: "Andrew", lastName: "Krier", whereFrom: "Saint Paul, MN", gender: .Male, role: .Student, degree: "Undergrad", hobbies: ["Basketball", "Frisbee"], languages: ["Java", "Python", "Swift"], team: "None")

people.append(contentsOf: [kaidi, ananjaya, ric, andrew])


/*
 * Helper functions and objects
 */

func makeString(p: DukePerson) -> String {
    var he : String
    var are : String
    var know : String
    
    switch p.gender {
    case .Male:
        he = "He"
        are = "is"
        know = "knows"
    case .Female:
        he = "She"
        are = "is"
        know = "knows"
    case .NonBinary:
        he = "They"
        are = "are"
        know = "know"
    }
    var deg : String
    if(p.degree == "N/A") {
        deg = ""
    } else {
        deg = p.degree + " "
    }
    
    return "\(p.firstName) \(p.lastName) \(are) from \(p.whereFrom). \(he) \(are) a \(deg)\(p.role) who enjoys \(listToString(s: p.hobbies)). \(he) \(know) \(listToString(s: p.languages)) and \(are) on team \(p.team)"
}

func listToString(s : [String]) -> String {
    var ret = ""
    
    if s.count == 0 { return "nothing" }
    if s.count == 1 {
        if(s[0] == "") { return "nothing" }
        return s[0]
    }
    else {
        for i in 1...s.count {
            if(i == 1) {
                ret = s[s.count - i]
            } else if(i == 2) {
                ret = s[s.count - i] + " and " + ret
            } else {
                ret = s[s.count - i] + ", " + ret
            }
        }
    }
    
    return ret
    
}

func findDukePerson(_ firstName: String, lastName: String) -> DukePerson {
    
    for i in 1...people.count {
        if(firstName == people[i-1].firstName && lastName == people[i-1].lastName) {
            return people[i-1]
        }
    }
    
    return DukePerson(firstName: "", lastName: "")
}

func findDukePersonIndex(_ firstName: String, lastName: String) -> Int {
    for i in 1...people.count {
        if(firstName == people[i-1].firstName && lastName == people[i-1].lastName) {
            return i-1
        }
    }
    return -1
}

func addUpdateDukePerson(newPerson: DukePerson) -> Void {
    
    var current = findDukePerson(newPerson.firstName, lastName: newPerson.lastName)
    if(current.firstName == "" && current.lastName == "") {
        people.append(newPerson)
    } else {
        current = newPerson
    }
    return
    
}

/*
 * Used for clear
 */

let emptyPerson = DukePerson(firstName: "", lastName: "", whereFrom: "", gender: .Male, role: .Professor, degree: "Undergrad", hobbies: [], languages: [], team: "")


/*
 * Starting values
 */

var currentPerson = emptyPerson
var genderIndex = 0
var roleIndex = 0
var degreeIndex = 0
var hobbiesString = ""
var langString = ""
var text = ""


func makePersonWithCurrent() -> DukePerson {
    
    if let first = fNameTextBox.text, let last = lNameTextBox.text {
        let p = DukePerson(firstName: first, lastName: last)
        
        if let from = homeTextBox.text {
            p.whereFrom = from
        }
        
        switch genderPicker.selectedSegmentIndex {
        case 0:
            p.gender = .Male
        case 1:
            p.gender = .Female
        default:
            p.gender = .NonBinary
        }
        
        switch rolePicker.selectedSegmentIndex {
        case 0:
            p.role = .Professor
        case 1:
            p.role = .TA
        case 2:
            p.role = .Student
        default:
            p.role = .Other
        }
        
        switch degreePicker.selectedSegmentIndex {
        case 0:
            p.degree = "Undergrad"
        case 1:
            p.degree = "Grad"
        default:
            p.degree =  "N/A"
        }
        
        if let hobbies = hobbiesTextBox.text {
            p.hobbies = hobbies.components(separatedBy: ", ")
        }
        
        if let langs = langTextBox.text {
            p.languages = langs.components(separatedBy: ", ")
        }
        
        if let team = teamTextBox.text {
            p.team = team
        }
        
        return p
    }
    
    return DukePerson(firstName: "", lastName: "")
}


func updatePerson(p: DukePerson) -> Void {
    currentPerson = p
    
    switch p.gender {
    case .Male:
        genderIndex = 0
    case .Female:
        genderIndex = 1
    default:
        genderIndex = 2
    }
    
    switch p.role {
    case .Professor:
        roleIndex = 0
    case .TA:
        roleIndex = 1
    case .Student:
        roleIndex = 2
    default:
        roleIndex = 3
    }
    
    switch p.degree {
    case "Undergrad":
        degreeIndex = 0
    case "Grad":
        degreeIndex = 1
    case "N/A":
        degreeIndex = 2
    default:
        degreeIndex = 0
    }
    
    hobbiesString = ""
    
    if(p.hobbies.count != 0) {
        for i in 1...p.hobbies.count {
            if(i != 1) {
                hobbiesString += ", "
            }
            hobbiesString += p.hobbies[i-1]
        }
    }
    
    langString = ""
    
    if(p.hobbies.count != 0) {
        for i in 1...p.languages.count {
            if(i != 1) {
                langString += ", "
            }
            langString += p.languages[i-1]
        }
    }
}


/*
 * UI Constants (some deprecated)
 */

let topStartingY = 50
let leftBorderX = 35
let rightStartingX = 35
let totalGapY = 45
let blockHeight = 35
let blockWidth = 300


/*
 * UI Objects
 */

let fNameTextBox = UITextField()
let lNameTextBox = UITextField()
let homeTextBox = UITextField()
let genderPicker = UISegmentedControl(items: [Gender.Male.rawValue, Gender.Female.rawValue, Gender.NonBinary.rawValue])
let rolePicker = UISegmentedControl(items: ["Professor", "TA", "Student", "Other"])
let degreePicker = UISegmentedControl(items: ["Undergrad", "Grad", "N/A"])
let hobbiesTextBox = UITextField()
let langTextBox = UITextField()
let teamTextBox = UITextField()




/*
 * COLORS!!!!
 */

let attributeColor = UIColor(red: 127/256, green: 121/256, blue: 121/256, alpha: 1)

let textColor = UIColor(red: 61/256, green: 59/256, blue: 60/256, alpha: 1)

let backgroundColor = UIColor(red: 193/256, green: 189/256, blue: 179/256, alpha: 1)

let buttonSliderColor = UIColor(red: 50/256, green: 48/256, blue: 49/256, alpha: 1)

let sliderColor = UIColor(red: 95/256, green: 91/256, blue: 107/256, alpha: 1)

let buttonTextColor = UIColor(red: 236/256, green: 229/256, blue: 240/256, alpha: 1)








/*
 * The main view
 */

class HW1ViewController : UIViewController {
    
    override func loadView() {
// You can change color scheme if you wish
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        // First name, text box
        
        fNameTextBox.textAlignment = .center
        fNameTextBox.frame = CGRect(x:rightStartingX, y: topStartingY, width: blockWidth, height: blockHeight)
        fNameTextBox.text = currentPerson.firstName
        fNameTextBox.textColor = textColor
        
        // placeholder code from https://stackoverflow.com/questions/1340224/iphone-uitextfield-change-placeholder-text-color
        
        fNameTextBox.attributedPlaceholder =
        NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: attributeColor])
        
        view.addSubview(fNameTextBox)
        
        // Last name, text box
        
        lNameTextBox.textAlignment = .center
        lNameTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + totalGapY, width: blockWidth, height: blockHeight)
        lNameTextBox.text = currentPerson.lastName
        lNameTextBox.textColor = textColor
        lNameTextBox.attributedPlaceholder =
        NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: attributeColor])
        view.addSubview(lNameTextBox)
        
        // Home, text box
        
        homeTextBox.textAlignment = .center
        homeTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 2 * totalGapY, width: blockWidth, height: blockHeight)
        homeTextBox.text = currentPerson.whereFrom
        homeTextBox.textColor = textColor
        homeTextBox.attributedPlaceholder =
        NSAttributedString(string: "City, State", attributes: [NSAttributedString.Key.foregroundColor: attributeColor])
        view.addSubview(homeTextBox)
        
        // Gender, picker
        
        genderPicker.tintColor = buttonSliderColor
        genderPicker.selectedSegmentTintColor = sliderColor
        genderPicker.frame = CGRect(x:rightStartingX, y: topStartingY + 3 * totalGapY, width: blockWidth, height: blockHeight)
        genderPicker.backgroundColor = .lightGray
        //genderPicker.selectedSegmentIndex = currentPerson.gender
        genderPicker.selectedSegmentIndex = genderIndex
        view.addSubview(genderPicker)
        
        // Role, picker
        
        rolePicker.selectedSegmentTintColor = sliderColor
        rolePicker.frame = CGRect(x:rightStartingX, y: topStartingY + 4 * totalGapY, width: blockWidth, height: blockHeight)
        rolePicker.backgroundColor = .lightGray
        rolePicker.selectedSegmentIndex = roleIndex
        view.addSubview(rolePicker)
        
        // Degree, picker
        
        degreePicker.selectedSegmentTintColor = sliderColor
        degreePicker.frame = CGRect(x:rightStartingX, y: topStartingY + 5 * totalGapY, width: blockWidth, height: blockHeight)
        degreePicker.backgroundColor = .lightGray
        degreePicker.selectedSegmentIndex = degreeIndex
        view.addSubview(degreePicker)
        
        // Hobbies, textbox
        
        hobbiesTextBox.textAlignment = .center
        hobbiesTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 6 * totalGapY, width: blockWidth, height: blockHeight)
        hobbiesTextBox.text = hobbiesString
        hobbiesTextBox.textColor = textColor
        hobbiesTextBox.attributedPlaceholder =
        NSAttributedString(string: "Hobbies: Running, etc", attributes: [NSAttributedString.Key.foregroundColor: attributeColor])
        view.addSubview(hobbiesTextBox)
        
        // Languages, text box
        
        langTextBox.textAlignment = .center
        langTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 7 * totalGapY, width: blockWidth, height: blockHeight)
        langTextBox.text = langString
        langTextBox.textColor = textColor
        langTextBox.attributedPlaceholder =
        NSAttributedString(string: "Languages: Swift, etc", attributes: [NSAttributedString.Key.foregroundColor: attributeColor])
        view.addSubview(langTextBox)
        
        // Team, textbox
        
        teamTextBox.textAlignment = .center
        teamTextBox.frame = CGRect(x:rightStartingX, y: topStartingY + 8 * totalGapY, width: blockWidth, height: blockHeight)
        teamTextBox.text = currentPerson.team
        teamTextBox.textColor = textColor
        teamTextBox.attributedPlaceholder =
        NSAttributedString(string: "Team", attributes: [NSAttributedString.Key.foregroundColor: attributeColor])
        view.addSubview(teamTextBox)
        
        // Add/Update button
        
        let addUpdateButton = UIButton()
        addUpdateButton.frame = CGRect(x:leftBorderX + 125, y: topStartingY + 9 * totalGapY, width: 175, height: blockHeight)
        addUpdateButton.setTitle("Add/Update", for: UIControl.State())
        addUpdateButton.setTitleColor(buttonTextColor, for: UIControl.State())
        //addUpdateButton.title
        addUpdateButton.backgroundColor = buttonSliderColor
        addUpdateButton.addTarget(self, action: #selector(addUpdate), for: .touchUpInside)
        addUpdateButton.layer.cornerRadius = 10
        view.addSubview(addUpdateButton)
        
        // Find button
        
        let findButton = UIButton()
        findButton.frame = CGRect(x:leftBorderX + 125, y: topStartingY + 10 * totalGapY, width: 75, height: blockHeight)
        findButton.setTitle("Find", for: UIControl.State())
        findButton.setTitleColor(buttonTextColor, for: UIControl.State())
        findButton.backgroundColor = buttonSliderColor
        findButton.addTarget(self, action: #selector(find), for: .touchUpInside)
        findButton.layer.cornerRadius = 10
        view.addSubview(findButton)
        
        // Clear button
        
        let clearButton = UIButton()
        clearButton.frame = CGRect(x:leftBorderX + 225, y: topStartingY + 10 * totalGapY, width: 75, height: blockHeight)
        clearButton.setTitle("Clear", for: UIControl.State())
        clearButton.setTitleColor(buttonTextColor, for: UIControl.State())
        clearButton.backgroundColor = buttonSliderColor
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        clearButton.layer.cornerRadius = 10
        view.addSubview(clearButton)
        
        // Bottom text box
        
        let out = UILabel()
        out.textAlignment = .center
        out.frame = CGRect(x:leftBorderX, y: topStartingY + 11 * totalGapY, width: 300, height: blockHeight * 3)
        out.text = text
        out.textColor = textColor
        out.backgroundColor = backgroundColor
        out.lineBreakMode = .byWordWrapping
        out.numberOfLines = 0
        view.addSubview(out)
        
        self.view = view
        
// You can add code here
    
    }
    
    // Objc buttons and event handling code from stackoverflow
    
    /*
     * Functions called by buttons
     */
    
    @objc func addUpdate() {
        if let firstName = fNameTextBox.text , let lastName = lNameTextBox.text {
            
            let person = makePersonWithCurrent()
            let i = findDukePersonIndex(firstName, lastName: lastName)
            
            if(i == -1) {
                people.append(person)
                text = makeString(p: person)
            } else {
                people.remove(at: i)
                people.append(person)
                text = makeString(p: person)
            }
            updatePerson(p: person)
            loadView()
        }
    }
    
    @objc func find() {
        
        if let firstName = fNameTextBox.text , let lastName = lNameTextBox.text {
            let p = findDukePerson(firstName, lastName: lastName)
            if p.firstName == "" {
                text = "This person was not found"
                loadView()
            } else {
                updatePerson(p: p)
                text = "Found person"
                text = makeString(p: p)
                loadView()
            }
            return
        }
        
    }
    
    @objc func clear() {
        updatePerson(p: emptyPerson)
        text = ""
        loadView()
    }
    
}
// Don't change the following line - it is what allows the view controller to show in the Live View window
PlaygroundPage.current.liveView = HW1ViewController()
