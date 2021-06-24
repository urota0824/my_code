
import UIKit

class EditViewController: UIViewController {
    
    //  空の配列を用意
    var strArray:[Str] = []
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    
    @IBOutlet weak var armTextField: UITextField!
    @IBOutlet weak var bellyTextField: UITextField!
    @IBOutlet weak var spineTextField: UITextField!
    @IBOutlet weak var squatTextField: UITextField!
    @IBOutlet weak var plankTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let strIndex = UserDefaults.standard.string(forKey: "index")
        let intIndex:Int = Int(strIndex!)!
        
        strArray = readItems()!
        
        var str = strArray[intIndex]
        
        yearTextField.text = str.year
        monthTextField.text = str.month
        dayTextField.text = str.day
        
        armTextField.text = str.arm
        bellyTextField.text = str.belly
        spineTextField.text = str.spine
        squatTextField.text = str.squat
        plankTextField.text = str.plank
        
    }
    
    func readItems() -> [Str]? {
        guard let items = UserDefaults.standard.array(forKey: "StrArrayKey") as? [Data] else { return [Str]() }
        
        let decodedItems = items.map { try! JSONDecoder().decode(Str.self, from: $0) }
        return decodedItems
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let strIndex = UserDefaults.standard.string(forKey: "index")
        let intIndex:Int = Int(strIndex!)!
        
        strArray[intIndex].year = yearTextField.text!
        strArray[intIndex].month = monthTextField.text!
        strArray[intIndex].day = dayTextField.text!
        
        strArray[intIndex].arm = armTextField.text!
        strArray[intIndex].belly = bellyTextField.text!
        strArray[intIndex].spine = spineTextField.text!
        strArray[intIndex].squat = squatTextField.text!
        strArray[intIndex].plank = plankTextField.text!
        
        let saveData = strArray.map { try! JSONEncoder().encode($0)}
        UserDefaults.standard.set(saveData as [Any], forKey: "StrArrayKey")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "page1") as! ViewController
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
}
