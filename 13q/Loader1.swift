import  Foundation
import Alamofire


class Loader1 {

    func load(completition: @escaping (String?) -> Void){
    var weather: NSDictionary = [:]
    var weatherHumidity = ""
    var weatherText = ""
    var weatherPressure = ""
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=524901&APPID=0658e215c1cec1feb4130ca4716178d7")!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonDict = json as? NSDictionary{
            
            weather = jsonDict["main"] as! NSDictionary
            
            var actualWeather:ActualWeather
            actualWeather = ActualWeather(data: weather)!
            weatherHumidity = String(actualWeather.humidity)

            let weatherTempCels = Int(actualWeather.temp - 273.15)
            weatherPressure = String(actualWeather.pressure)
            
            weatherText = "Actual weather in Moscow:\n" +
                "Humidity: \(weatherHumidity)\n" + "Temperature: \(weatherTempCels)ºC\n" + "Pressure: \(weatherPressure)"
            
            
            completition(weatherText)} else {
            completition(nil)
        }}
    task.resume()
}

    func load5Days(completition: @escaping ([Category]) ->Void){
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=0658e215c1cec1feb4130ca4716178d7")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary,
                let list = jsonDict["list"] as? [NSDictionary]{
                var categories: [Category] = []
                
                var category:Category
                
                
                for data in list{
                    category = Category(data: data)!
                    categories.append(category)
                   
                }
                DispatchQueue.main.async {
                    completition(categories)
                }
                
            }
        }
        task.resume()
    }
}




    
    
    
    


