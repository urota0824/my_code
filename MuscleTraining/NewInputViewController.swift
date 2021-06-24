
import UIKit

class NewInputViewController: UIViewController, UITextFieldDelegate {
    
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
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(withIdentifier: "history")
        self.navigationController?.pushViewController(second, animated: true)
        
        let str = Str(year: yearTextField.text!, month: monthTextField.text!, day: dayTextField.text!, arm: armTextField.text!, belly: bellyTextField.text!, spine: spineTextField.text!, squat: squatTextField.text!, plank: plankTextField.text!)
        
        // `JSONEncoder` で `Data` 型へエンコードし、UserDefaultsに追加する
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? jsonEncoder.encode(str) else {
            return
        }
        UserDefaults.standard.set(data, forKey: "SaveKey")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
