//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//
import UIKit
import AlamofireImage
import Lottie
import SkeletonView
import MapKit
import CoreLocation

protocol DisplayViewControllerDelegate : NSObjectProtocol{
    func doSomethingWith(data: Restaurant)
}

class RestaurantsViewController: UIViewController, CLLocationManagerDelegate{
    weak var delegate : DisplayViewControllerDelegate?
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    var restaurantsArray: [Restaurant] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredRestaurants: [Restaurant] = []
    
    // Variable inits
    var animationView: AnimationView?
    var refresh = true
    
    let yelpRefresh = UIRefreshControl()
    var restCount = 0
    let locationManager = CLLocationManager()
    var long: Double = -122.431297
    var lat: Double = 37.773972
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //startAnimations()
        // Table View
        //tableView.visibleCells.forEach { $0.showSkeleton() }
        tableView.delegate = self
        tableView.dataSource = self

        // Search Bar delegate
        searchBar.delegate = self
       
        // Get Data from API
        print("GEt API")
        getAPIData()
        
        yelpRefresh.addTarget(self, action: #selector(getAPIData), for: .valueChanged)
        tableView.refreshControl = yelpRefresh
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
       // print("===locations = \(locValue.latitude) \(locValue.longitude)")
        lat = Double(locValue.latitude)
        long = Double(locValue.longitude)
    }
    
    @objc func getAPIData() {
        loadRestaurants()
        tableView.refreshControl = yelpRefresh
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadRestaurants(){
       // print("reload")
        
        
       // var locationRestaurant = locationSearchBar.text
        //if(locationRestaurant == "") {locationRestaurant = "79424"}
        API.getRestaurants(lat: self.lat, long: self.long) { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
    
            self.restaurantsArray = restaurants
            self.filteredRestaurants = restaurants
            self.tableView.reloadData()
            
            //Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopAnimations), userInfo: nil, repeats: false)
            self.restCount = restaurants.count
            self.yelpRefresh.endRefreshing()
            
        }
    }
    
    func loadMoreRestaurants(){
       // print("reload")
        API.getMorerestaurants(numberOfRestaurants: self.restCount + 10,lat: self.lat, long: self.long) { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
    
            self.restaurantsArray = restaurants
            self.filteredRestaurants = restaurants
            self.restCount = self.restCount + restaurants.count
            self.tableView.reloadData()
            self.yelpRefresh.endRefreshing()
            
        }
    }
}


// ––––– TableView Functionality –––––
extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == restCount{
            loadMoreRestaurants()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        // Set cell's restaurant
        cell.r = filteredRestaurants[indexPath.row]

        // Initialize skeleton view every time cell gets initialized
      //  cell.showSkeleton()
        
        // Stop animation after like .5 seconds
        func refresh() {
            run(after: 2) {
               self.yelpRefresh.endRefreshing()
            }
        }
        
        return cell
    }
    //click any restaurant send the data back to host
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRest = restaurantsArray[indexPath.row]

        if let delegate = delegate{
            delegate.doSomethingWith(data: selectedRest)
            }
        self.dismiss(animated: true, completion: nil)
        }
    // ––––– TODO: Send restaurant object to DetailViewController
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//        if let indexPath = tableView.indexPath(for: cell) {
////            let r = filteredRestaurants[indexPath.row]
////            let detailViewController = segue.destination as! RestaurantDetailViewController
////            detailViewController.r = r
//        }
//
//    }
    
}


// ––––– UI SearchBar Functionality –––––
extension RestaurantsViewController: UISearchBarDelegate {
    
    // Search bar functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredRestaurants = restaurantsArray.filter { (r: Restaurant) -> Bool in
              return r.name.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            filteredRestaurants = restaurantsArray
        }
        tableView.reloadData()
    }

    
    // Show Cancel button when typing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       self.searchBar.showsCancelButton = true
    }
       
    // Logic for searchBar cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.showsCancelButton = false // remove cancel button
       searchBar.text = "" // reset search text
       searchBar.resignFirstResponder() // remove keyboard
       filteredRestaurants = restaurantsArray // reset results to display
       tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // self.dismiss(animated: true, completion: nil)
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        print("data to:")
        if(segue.identifier == "RestaurantsViewController"){
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let r = filteredRestaurants[indexPath.row]
                let detailViewController = segue.destination as! HostViewController
                detailViewController.r = r
            }
            }
        
    }
     */
    
    
}
