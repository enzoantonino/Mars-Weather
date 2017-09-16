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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.archiveTableView.dataSource = self
        self.archiveTableView.tableHeaderView = UIView()
        self.archiveTableView.tableFooterView = UIView()
        
        dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .long
        
        self.fetchData()
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
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath)
            
            if let date = weathers[indexPath.row].terrestrialDate {
                cell.textLabel?.text = self.dateFormatter.string(from: date)
            } else {
                
            }
            cell.detailTextLabel?.text = weathers[indexPath.row].atmoOpacity != nil ? weathers[indexPath.row].atmoOpacity : "No data"
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath)
            self.page += 1
            self.fetchData()
            return cell
        }
    }
    
}
