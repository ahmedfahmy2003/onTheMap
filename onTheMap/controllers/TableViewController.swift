//
//  TableTableViewController.swift
//  PinSample
//
//  Created by Ammar AlTahhan on 18/11/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class TableViewController: ContainerViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override var locationsData: LocationsData? {
        didSet {
            guard let locationsData = locationsData else { return }
            locations = locationsData.studentLocations
        }
    }
    var locations: [StudentLocation] = [] {
        didSet {
            tableView.reloadData()
        }
    }

}


extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell" ,for: indexPath )
        cell.textLabel?.text = "\(locations[indexPath.row].firstName ?? "") \(locations[indexPath.row].lastName ?? "")"
        cell.detailTextLabel?.text = (locations[indexPath.row].mapString)
        
        //cell.studentLocation = locations[indexPath.row]
        return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let urlString = locations[indexPath.row].mediaURL else {
            showAlert(title: "Invalid URL1", message: "Invalid mediaURL")
            return
        }
        guard let url = URL(string: urlString) else{
            showAlert(title: "Invalid URL2", message: "Invalid mediaURL")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
}
