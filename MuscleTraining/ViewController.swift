
import UIKit

class ViewController: UIViewController {
    
    @IBAction func yearTextField(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 表示したい画像の名前(拡張子含む)を引数とする。
        self.view.addBackground(name: "arm")
        
        UserDefaults.standard.removeObject(forKey: "StrArrayKey")
        
        
    }
    
    @IBAction func historyButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        //履歴画面へ画面遷移させる（う）
        let second = storyboard.instantiateViewController(withIdentifier: "history")
        self.navigationController?.pushViewController(second, animated: true)
        
    }
    
    
}

