

import UIKit

class ViewController2: UIViewController {
    
    var weatherText = ""

    @IBOutlet weak var label2: UILabel!


override func viewDidLoad() {
        super.viewDidLoad()
        let loader2 = Loader2()
        loader2.delegate2 = self
        loader2.load2()
    }}

extension ViewController: LoadDelegate2 {
    func loaded2(_ weatherText: String) {
        label2.text = "Actual weather in Moscow: \(weatherText)"
    }}
