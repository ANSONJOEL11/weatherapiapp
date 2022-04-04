//
//  ViewController.swift
//  weatherapiapp
//
//  Created by Anson Joel Arul Joseph Maria on 2022-04-03.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var currentWeatherCondition: UILabel!
    @IBOutlet weak var currentWeatherConditionImage: UIImageView!
    
    @IBOutlet weak var tempinC: UILabel!
    
    @IBOutlet weak var tempinF: UILabel!
    
    @IBOutlet weak var searchBar: UITextField!
    
    

    let location = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        searchBar.delegate = self
        location.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        }
        
        
        
        
        
//        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//                switch status {
//                case .notDetermined:
//                    print("not determined - hence ask for Permission")
//                    manager.requestWhenInUseAuthorization()
//                case .restricted, .denied:
//                    print("permission denied")
//                case .authorizedAlways, .authorizedWhenInUse:
//                    print("Apple delegate gives the call back here once user taps Allow option, Make sure delegate is set to self")
//                @unknown default:
//                    print("fatal")
//                }
//            }
        func searchBarProperty(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            weatherApidata(search: textField.text)
            return true
        }
        
        let defaultImageSettings = UIImage.SymbolConfiguration(paletteColors: [.systemGreen,.systemBlue,.systemYellow])
        currentWeatherConditionImage.preferredSymbolConfiguration = defaultImageSettings
        currentWeatherConditionImage.image = UIImage(systemName: "cloud.fog.fill")
    }
    
    @IBAction func currentLocationBtn(_ sender: Any) {
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        
        weatherApidata(search: "London")
        
    }
    @IBAction func searchBarBtn(_ sender: Any) {
        searchBar.endEditing(true)
        weatherApidata(search: searchBar.text)
    }
    
    
    
    func weatherApidata(search:String?) {
            guard let location = search else {
                return
            }
            let url = urldata(location: location)
            
            guard let url = url else{
                print("Error")
                return
            }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, responce, error in
            
            guard error == nil else{
                return
            }
            
            guard let data = data else{
                return
            }
            
            if let weather = self.JSONDecode(data: data) {
                
                DispatchQueue.main.async {
                    self.currentLocation.text = weather.location.name
                    self.tempinC.text = "\(weather.current.temp_c)\u{00B0} C"
                    self.currentWeatherCondition.text = weather.current.condition.text
                    self.imageforImageView(code: weather.current.condition.code)
                    self.tempinF.text = "\(weather.current.temp_f)\u{00B0} F"
                }
            }
        }
        dataTask.resume()
    }
    
    func JSONDecode(data:Data) -> weatherStruct? {
        let decoder = JSONDecoder()
        var weatherData:weatherStruct?
        
        do {
            weatherData =  try decoder.decode(weatherStruct.self, from: data)
        } catch{
        }
        return weatherData
    }
    
    func urldata(location:String) -> URL? {
        let baseurl = "https://api.weatherapi.com/v1/"
        let endpoint = "current.json"
        let APIKey = "3c2c33e01ffb47af89d234233220304"
        let url = "\(baseurl)\(endpoint)?key=\(APIKey)&q=\(location)"
        return URL(string: url)
    }
    
    private func imageforImageView(code:Int) {
        switch code {
        case 1000:
            imageFunction(img: "sun.max.fill")
        case 1003:
            imageFunction(img: "cloud.sun.fill")
        case 1006:
            imageFunction(img: "cloud.fill")
        case 1009:
            imageFunction(img: "cloud.fill")
        case 1030:
            imageFunction(img: "waveform")
        case 1063:
            imageFunction(img: "scloud.sun.rain.fill")
        case 1066:
            imageFunction(img: "cloud.snow")
        case 1069:
            imageFunction(img: "cloud.sleet")
        case 1072:
            imageFunction(img: "cloud.drizzle.fill")
        case 1087:
            imageFunction(img: "cloud.sun.bolt.fill")
        case 1114:
            imageFunction(img: "cloud.snow.fill")
        case 1117:
            imageFunction(img: "cloud.snow.fill")
        case 1135:
            imageFunction(img: "cloud.fog")
        case 1147:
            imageFunction(img: "cloud.fog.fill")
        case 1150:
            imageFunction(img: "cloud.drizzle")
        case 1153:
            imageFunction(img: "cloud.drizzle.fill")
        case 1168:
            imageFunction(img: "cloud.drizzle.fill")
        case 1171:
            imageFunction(img: "scloud.drizzle.fill")
        case 1180:
            imageFunction(img: "cloud.sun.rain.fill")
        case 1183:
            imageFunction(img: "cloud.rain.fill")
        case 1186:
            imageFunction(img: "ccloud.sun.rain.fill")
        case 1189:
            imageFunction(img: "cloud.rain.fill")
        case 1192:
            imageFunction(img: "cloud.sun.rain.fill")
        case 1195:
            imageFunction(img: "cloud.heavyrain.fill")
        case 1198:
            imageFunction(img: "cloud.heavyrain.fill")
        case 1201:
            imageFunction(img: "cloud.heavyrain.fill")
        case 1204:
            imageFunction(img: "cloud.sleet")
        case 1207:
            imageFunction(img: "cloud.sleet")
        case 1210:
            imageFunction(img: "cloud.snow")
        case 1213:
            imageFunction(img: "cloud.snow")
        case 1216:
            imageFunction(img: "cloud.snow")
        case 1219:
            imageFunction(img: "cloud.snow")
        case 1222:
            imageFunction(img: "cloud.snow")
        case 1225:
            imageFunction(img: "cloud.snow")
        case 1237:
            imageFunction(img: "cloud.snow")
        case 1240:
            imageFunction(img: "cloud.sun.rain.fill")
        case 1243:
            imageFunction(img: "cloud.sun.rain.fill")
        case 1246:
            imageFunction(img: "cloud.sun.rain.fill")
        case 1249:
            imageFunction(img: "cloud.sleet")
        case 1252:
            imageFunction(img: "cloud.sleet")
        case 1255:
            imageFunction(img: "cloud.snow.fill")
        case 1258:
            imageFunction(img: "cloud.snow.fill")
        case 1261:
            imageFunction(img: "cloud.snow.fill")
        case 1264:
            imageFunction(img: "cloud.sleet.fill")
        case 1273:
            imageFunction(img: "cloud.sun.bolt.fill")
        case 1276:
            imageFunction(img: "cloud.bolt.fill")
        case 1279:
            imageFunction(img: "cloud.sun.bolt.fill")
        case 1282:
            imageFunction(img: "cloud.bolt.fill")
        default:
            print("Image is not available")
        }
    }
    
    private func imageFunction(img:String){
        let imageSettings = UIImage.SymbolConfiguration(paletteColors: [.systemGreen,.systemBlue,.systemYellow])
        currentWeatherConditionImage.preferredSymbolConfiguration = imageSettings
        currentWeatherConditionImage.image = UIImage(systemName: img)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location")
        
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("LatLong: (\(latitude), \(longitude)")
            let searchOption = "\(latitude),\(longitude)"
            weatherApidata(search: searchOption)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


struct weatherStruct:Decodable {
    let location:Location
    let current:Current
}

struct Location:Decodable {
    let name:String
    let country:String
}

struct Current:Decodable {
    let temp_c:Float
    let temp_f:Float
    let condition:Condition
    
}

struct Condition:Decodable {
    let text:String
    let icon:String
    let code:Int
    
}

        
        

