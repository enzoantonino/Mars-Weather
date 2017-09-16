//
//  ArchiveViewController.swift
//  MarsWeather
//
//  Created by Enzo Antonino on 16/09/2017.
//  Copyright © 2017 Enzo Antonino. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ArchiveViewController: UIViewController {
    
    @IBOutlet var archiveTableView: UITableView!
    
    var weathers: [Weather] = []
    var dateFormatter: DateFormatter!
    var page: Int = 0
    var expandedRow: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.archiveTableView.dataSource = self
        self.archiveTableView.delegate = self
        self.archiveTableView.tableHeaderView = UIView()
        self.archiveTableView.tableFooterView = UIView()
        self.archiveTableView.estimatedRowHeight = 44
        self.archiveTableView.rowHeight = UITableViewAutomaticDimension
        
        dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .long
        
//        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        
        Alamofire
            .request(Router.archive(page: self.page))
            .responseObject { (response: DataResponse<WeatherArchiveResponse>) in
                
                switch response.result {
                case .success(let weatherArchive):
                    if let _ = weatherArchive.results {
                        self.weathers.append(contentsOf: weatherArchive.results!)
                        self.archiveTableView.reloadData()
                    }
                case .failure:
                    print("failure")
                }
                
        }
        
    }
    
}

extension ArchiveViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < self.weathers.count {
            
            if indexPath == self.expandedRow {
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandedArchiveCell", for: indexPath) as! ExpandedArchiveTableViewCell
                
                let weather = self.weathers[indexPath.row]
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = NSLocale.current
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.dateStyle = .short
                
                if weather.marsDate != nil {
                    cell.solLabel.text = "\(weather.marsDate!)"
                }
                
                if weather.terrestrialDate != nil {
                    cell.terrestrialDateLabel.text = dateFormatter.string(from: weather.terrestrialDate!)
                }
                
                if weather.atmoOpacity != nil {
                    cell.atmoOpacityLabel.text = weather.atmoOpacity!
                }
                
                if weather.marsSeason != nil {
                    cell.lsLabel.text = "\(weather.marsSeason!)"
                }
                
                if weather.minTemp != nil {
                    cell.minTempLabel.text = "\(weather.minTemp!)"
                }
                
                if weather.maxTemp != nil {
                    cell.maxTempLabel.text = "\(weather.maxTemp!)"
                }
                
                if weather.absHumidity != nil {
                    cell.absHumidityLabel.text = weather.absHumidity!
                } else {
                    cell.absHumidityLabel.text = "--"
                }
                
                if weather.windSpeed != nil {
                    cell.windLabel.text = "\(weather.windSpeed!)"
                } else {
                    cell.windLabel.text = "--"
                }
                
                if weather.windDirection != nil {
                    cell.windLabel.text = "\(cell.windLabel.text!) \(weather.windDirection!)"
                }
                
                if weather.season != nil {
                    cell.seasonLabel.text = weather.season!
                }
                
                if weather.sunrise != nil {
                    cell.sunriseLabel.text = dateFormatter.string(from: weather.sunrise!)
                }
                
                if weather.sunset != nil {
                    cell.sunsetLabel.text = dateFormatter.string(from: weather.sunset!)
                }
                
                if weather.pressure != nil {
                    cell.pressureLabel.text = "\(weather.pressure!)"
                } else {
                    cell.pressureLabel.text = "--"
                }
                
                if weather.pressureString != nil {
                    cell.pressureLabel.text = "\(cell.pressureLabel.text!) - \(weather.pressureString!)"
                }
                
                return cell

            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath)
                
                if let date = weathers[indexPath.row].terrestrialDate {
                    cell.textLabel?.text = self.dateFormatter.string(from: date)
                } else {
                    
                }
                cell.detailTextLabel?.text = weathers[indexPath.row].atmoOpacity != nil ? weathers[indexPath.row].atmoOpacity : "No data"
                
                return cell
            }
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "expandedArchiveCell", for: indexPath)
            self.page += 1
            self.fetchData()
            return cell
        }
    }
    
}

extension ArchiveViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        var indexPathToReload: [IndexPath] = [indexPath]
        if let _ = self.expandedRow {
            if indexPath == self.expandedRow {
                self.expandedRow = nil
            } else {
                indexPathToReload.append(self.expandedRow!)
                self.expandedRow = indexPath
            }
        } else {
            self.expandedRow = indexPath
        }
        
        tableView.reloadRows(at: indexPathToReload, with: .automatic)
    }
    
}
