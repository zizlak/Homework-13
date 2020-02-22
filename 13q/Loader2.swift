import  Foundation
import Alamofire

class Loader2 {
    
    func load2(completition: @escaping (String?) -> Void){
        var weather: NSDictionary = [:]
        var weatherText = ""
        
        var weatherHumidity = ""
        var weatherPressure = ""
        
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?id=524901&APPID=0658e215c1cec1feb4130ca4716178d7").responseJSON
            { response in
                if let objects = response.result.value,
                    let jsonDict2 = objects as? NSDictionary {
                    
                    weather = jsonDict2["main"] as! NSDictionary
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

    }
    
    func load5Days(completition: @escaping ([Category]) ->Void){
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=0658e215c1cec1feb4130ca4716178d7").responseJSON{
            response in
            if let objects = response.result.value,
                let jsonDict = objects as? NSDictionary,
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
    }
}
   
