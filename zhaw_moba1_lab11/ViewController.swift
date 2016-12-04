//
//  ViewController.swift
//  zhaw_moba1_lab11
//
//  Created by José Miguel Rota on 04.12.16.
//  Copyright © 2016 José Miguel Rota. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var inputX: UITextField!
    @IBOutlet weak var inputY: UITextField!
    @IBOutlet weak var tableView: PostOfficeTableView!
    
    var filteredPostOffices: [PostOffice] = []
    let postOfficeStore = PostOfficeStore()
    let locationManager = CLLocationManager()
    let textCellIdentifier = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.getlocationForUser()
        
        self.postOfficeStore.load(file: "post-switzerland", type: "txt")
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickBtnSearch(_ sender: Any) {
        //let x = Double(inputX.text ?? "0")!
        //let y = Double(inputY.text ?? "0")!
        self.filterPostOffices(x: 0, y: 0)
    }
    
    func filterPostOffices(x: Double, y: Double) {
        self.filteredPostOffices = self.postOfficeStore.filter(x: x, y: y, distance: 5)
        self.tableView.reloadData()
    }
    
    func getlocationForUser() {
        if CLLocationManager.locationServicesEnabled() {
            //Then check whether the user has granted you permission to get his location
            if CLLocationManager.authorizationStatus() == .notDetermined {
                //Request permission
                //Note: you can also ask for .requestWhenInUseAuthorization
                locationManager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied {
                //... Sorry for you. You can huff and puff but you are not getting any location
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        inputX.text = "\(location?.coordinate.longitude)"
        inputY.text = "\(location?.coordinate.latitude)"
        self.filterPostOffices(x: (location?.coordinate.longitude)!, y: (location?.coordinate.latitude)!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.filteredPostOffices.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.textCellIdentifier, for: indexPath)
        let postOffice = self.filteredPostOffices[indexPath.row]
        cell.textLabel?.text = postOffice.name ?? "No Name Provided"
        
        return cell
    }
}

