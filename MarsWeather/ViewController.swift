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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                let weatherResponse = response.result.value
                print(weatherResponse)
        }
        
    }


}

