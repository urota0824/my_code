
import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    //検索するときはアルファベットでやること！
    
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var appTableView: UITableView!
    
    var imageArray:[String] = []
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appTableView.delegate = self
        appTableView.dataSource = self
                
        }
        
    func getImages(surchWord:String) {
                    
            //APIkey 17617424-ce248788983e8785377ef6493
            let url = "https://pixabay.com/api/?key=17617424-ce248788983e8785377ef6493&q=" + surchWord
        
            //Alamofireを使ってhttpリクエストを投げます。
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (respons) in
                
                switch respons.result{
                    
                case .success:
                    
                    let json:JSON = JSON(respons.data as Any)
                    
                    for (index: String, subJson: JSON) in json["hits"] {
                        // 0,1,2,3...
                        self.imageArray.append(JSON["webformatURL"].string!)
                        
                        self.count += 1
                        if self.count > 9 {
                            break
                        }

                    }
                    
                    self.count = 0
                    
                case .failure(let error): break
                    
                }
                self.appTableView.reloadData()
            }

        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return imageArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                        
            // URLよりイメージ画像を変換してCELLに貼り付け
            let url = URL(string: imageArray[indexPath.row])
            
            do {
                
                
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
                iv.image = image
                cell.contentView.addSubview(iv)
                
             }catch let err {
                print("Error : \(err.localizedDescription)")
             }
            
            return cell
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func surchButton(_ sender: Any) {
        
        var surchWord = String(wordText.text!)
        imageArray.removeAll()
        
        getImages(surchWord: surchWord)
        
    }
    
    
}

