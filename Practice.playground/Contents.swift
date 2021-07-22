import UIKit
import PlaygroundSupport

// This playground is here just for you to practice different Swift operations.
// Once you have a function working the way you want, you can copy it in to HW1.playground to start testing with your User Interface.
// The contents of this playground is not graded, so you don't have to use and you can even delete it if you want.

func testDog(dogName: String?) -> String {
    guard let theName = dogName else {
        return "no value"
    }
    return theName
}

var dogOne:String?
let dogTwo = "Brier"
let myDog = testDog(dogName: dogOne)

var sampleText = "Hello World"
print(sampleText)

var text = "old text"

class HW1ViewController : UIViewController {
    
    override func loadView() {
// You can change color scheme if you wish
        let view = UIView()
        view.backgroundColor = .black
        
        let textbox = UILabel()
        textbox.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        textbox.text = text
        textbox.textColor = .white
        view.addSubview(textbox)
        
        let button = UIButton()
        button.frame = CGRect(x:20, y: 50, width: 200, height: 20)
        button.backgroundColor = .white
        button.setTitle("button", for: UIControl.State())
        button.setTitleColor(.black, for: UIControl.State())
        button.addTarget(self, action: #selector(changeString), for: UIControl.Event())
        view.addSubview(button)
        
        self.view = view
        
    }
    
    @objc func changeString() -> Void {
        text = "new text"
        loadView()
        
        return
    }
    
}
// Don't change the following line - it is what allows the view controller to show in the Live View window
PlaygroundPage.current.liveView = HW1ViewController()
