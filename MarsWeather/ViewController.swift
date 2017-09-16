//
//  ViewController.swift
//  MarsWeather
//
//  Created by Enzo Antonino on 16/09/2017.
//  Copyright © 2017 Enzo Antonino. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {

    @IBOutlet var solLabel: UILabel!
    @IBOutlet var terrestrialDateLabel: UILabel!
    @IBOutlet var atmoOpacityLabel: UILabel!
    @IBOutlet var lsLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var absHumidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.backgroundImageView.image = #imageLiteral(resourceName: "mars")
        
        //fetch data
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        
        Alamofire
            .request(Router.latest)
            .responseObject { (response: DataResponse<WeatherResponse>) in
                
                switch response.result {
                case .success(let weatherResponse):
                    if let weather = weatherResponse.report {
                        self.fillUI(weather: weather)
                    }
                case .failure:
                    print("failure")
                    let alert = UIAlertController(title: "Attention!", message: "Something went wrong during the download of informations", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        print("ok button choosed!")
                    }))
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                        print("retry")
                        self.fetchData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
        }
        
    }
    
    private func fillUI(weather: Weather) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .short
        
        let hourFormatter = DateFormatter()
        hourFormatter.locale = NSLocale.current
        hourFormatter.timeZone = TimeZone.current
        hourFormatter.dateFormat = "HH:mm"
        
        if weather.marsDate != nil {
            self.solLabel.text = "\(weather.marsDate!)"
        }
        
        if weather.terrestrialDate != nil {
            self.terrestrialDateLabel.text = dateFormatter.string(from: weather.terrestrialDate!)
        }
        
        if weather.atmoOpacity != nil {
            self.atmoOpacityLabel.text = weather.atmoOpacity!
        }
        
        if weather.marsSeason != nil {
            self.lsLabel.text = "\(weather.marsSeason!)"
        }
        
        if weather.minTemp != nil {
            self.minTempLabel.text = "\(weather.minTemp!)"
        }
        
        if weather.maxTemp != nil {
            self.maxTempLabel.text = "\(weather.maxTemp!)"
        }
        
        if weather.absHumidity != nil {
            self.absHumidityLabel.text = weather.absHumidity!
        } else {
            self.absHumidityLabel.text = "--"
        }
        
        if weather.windSpeed != nil {
            self.windSpeedLabel.text = "\(weather.windSpeed!)"
        } else {
            self.windSpeedLabel.text = "--"
        }
        
        if weather.windDirection != nil {
            self.windSpeedLabel.text = "\(self.windSpeedLabel.text!) \(weather.windDirection!)"
        }
        
        if weather.season != nil {
            self.seasonLabel.text = weather.season!
        }
        
        if weather.sunrise != nil {
            self.sunriseLabel.text = hourFormatter.string(from: weather.sunrise!)
        }
        
        if weather.sunset != nil {
            self.sunsetLabel.text = hourFormatter.string(from: weather.sunset!)
        }
        
//        if weather.minTempFahrenheit != nil {
//            self.minTempFarLabel.text = "\(weather.minTempFahrenheit!)"
//        }
//        
//        if weather.maxTempFahrenheit != nil {
//            self.maxTempFarLabel.text = "\(weather.maxTempFahrenheit!)"
//        }
        
        if weather.pressure != nil {
            self.pressureLabel.text = "\(weather.pressure!)"
        } else {
            self.pressureLabel.text = "--"
        }
        
        if weather.pressureString != nil {
            self.pressureLabel.text = "\(self.pressureLabel.text!) - \(weather.pressureString!)"
        }

    }


}

