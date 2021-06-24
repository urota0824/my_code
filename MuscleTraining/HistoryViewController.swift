
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    //  空の配列を用意
    var strArray:[Str] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("a")
        
        // StrArrayKeyがNilでない かつ SaveKeyがNilでない ＝ 履歴もあり、登録データあり なので
        // ReadItemsとSaveItemsを呼び出し
        if ((UserDefaults.standard.array(forKey: "StrArrayKey") != nil) && (UserDefaults.standard.data(forKey: "SaveKey") != nil)) {
            strArray = readItems()!
            saveItems(items: strArray)
        }
        
        // StrArrayKeyがNil かつ SaveKeyがNilでない　＝ 履歴はないが、登録データあり　なので
        // SaveItemsだけ呼び出し
        if ((UserDefaults.standard.array(forKey: "StrArrayKey") == nil) && (UserDefaults.standard.data(forKey: "SaveKey") != nil)) {
            saveItems(items: strArray)
        }
        
        // StrArrayKeyがNilでない かつ SaveKeyがNil ＝ 履歴はあるが、登録データがない　なので
        // ReadItemsだけ呼び出し
        if ((UserDefaults.standard.array(forKey: "StrArrayKey") != nil) && (UserDefaults.standard.data(forKey: "SaveKey") == nil)) {
            strArray = readItems()!
        }
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }
    
    func saveItems(items: [Str]) {
        
        // `JSONDecoder` で `Data` 型を自作した構造体へデコードする
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: "SaveKey"),
              let str = try? jsonDecoder.decode(Str.self, from: data) else {
            return
        }
        
        let readData = items.map { try! JSONEncoder().encode($0) }
        var strArray = readData.map {try! JSONDecoder().decode(Str.self, from: $0) }
        strArray.append(str)
        let saveData = strArray.map { try! JSONEncoder().encode($0)}
        UserDefaults.standard.set(saveData as [Any], forKey: "StrArrayKey")
        UserDefaults.standard.removeObject(forKey: "SaveKey")
        
    }
    
    func readItems() -> [Str]? {
        guard let items = UserDefaults.standard.array(forKey: "StrArrayKey") as? [Data] else {
            return [Str]()
        }
        
        let decodedItems = items.map { try! JSONDecoder().decode(Str.self, from: $0) }
        return decodedItems
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return strArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
        
        cell.textLabel?.text = strArray[indexPath.row].year
        
        return cell
    }
    
    // セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            strArray.remove(at: indexPath.row)
            
            let saveData = strArray.map { try! JSONEncoder().encode($0)}
            UserDefaults.standard.set(saveData as [Any], forKey: "StrArrayKey")
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var indexNumber = indexPath.item
        UserDefaults.standard.set(String(indexNumber), forKey: "index")
        
        let targetViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController")as! UIViewController
        targetViewController.modalPresentationStyle = .fullScreen
        self.present(targetViewController, animated: true, completion: nil)
    }
    
}
