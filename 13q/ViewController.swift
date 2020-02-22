
import UIKit
import Alamofire

class ViewController: UIViewController {
    
var categories: [Category] = []
    
@IBOutlet weak var label: UILabel!
    
@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader1 = Loader1()
    
    loader1.load{(string) in
        DispatchQueue.main.async{
            if let string = string{
                self.label.text = "\(string)"}
            else{self.label.text = "Error"}
        }}

        loader1.load5Days{categories in
            DispatchQueue.main.async{
            self.categories = categories
                
                self.tableView.reloadData()}
}
    }
    }
        

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let model = categories[indexPath.row]
        let kelvin: Double = model.main1["temp"]! as! Double
        let celsius: Int = Int(kelvin) - Int(273.15)
    
        cell.label1.text = model.dtTxt
        cell.label2.text = "Temperature: \(celsius)ºC\n" + "Pressure: \(model.main1["pressure"]!)\n" + "Humidity: \(model.main1["humidity"]!)\n" + "Wind speed: \(model.wind["speed"]!)m/s \n" + "\(model.weather[0]["main"]!)"
        
        return cell
    }
}



