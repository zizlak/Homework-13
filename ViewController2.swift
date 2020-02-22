
import UIKit
import Alamofire


class ViewController2: UIViewController {
    
    var categories: [Category] = []
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader2 = Loader2()

        loader2.load2{(string) in
            DispatchQueue.main.async{
                if let string = string{
                    self.label2.text = "\(string)"}
                else{self.label2.text = "Error"}
            }}
        
        loader2.load5Days{categories in
            DispatchQueue.main.async{
                self.categories = categories
                self.tableView2.reloadData()}
        }
    }

}

extension ViewController2: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! TableViewCell2
        let model = categories[indexPath.row]
        let kelvin: Double = model.main1["temp"]! as! Double
        let celsius: Int = Int(kelvin) - Int(273.15)
        
        cell.label11.text = model.dtTxt
        cell.label12.text = "Temperature: \(celsius)ºC\n" + "Pressure: \(model.main1["pressure"]!)\n" + "Humidity: \(model.main1["humidity"]!)\n" + "Wind speed: \(model.wind["speed"]!)m/s\n" + "\(model.weather[0]["main"]!)"
        
        return cell
    }
}
