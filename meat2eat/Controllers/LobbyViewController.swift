//
//  LobbyViewController.swift
//  meat2eat
//
//  Created by Hew, Vincent on 11/13/21.
//

import UIKit
import Parse
import AlamofireImage



class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, filterDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tables = [PFObject]()
    var capacityFilter = 10
    var numberOfLoad: Int!
    let lobbyRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        lobbyRefreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = lobbyRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Tables")
        query.includeKey("host")
        query.whereKey("max", lessThanOrEqualTo: capacityFilter)
        numberOfLoad = 20
        query.limit = numberOfLoad
        
        query.findObjectsInBackground{ (tables, error) in
            if tables != nil {
                print("Retrieving tables data")
                self.tables = tables!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        
        let table = tables[indexPath.row]
        // unit 5 video parstagram 6
        cell.restaurantNameLabel.text = table["restaurantName"] as? String
        cell.restaurantLocLabel.text = table["restaurantLoc"] as? String
        cell.currentLabel.text = "\(table["current"]!)"
        cell.maxLabel.text = "\(table["max"]!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTable = tables[indexPath.row]
        print("\(selectedTable["current"]!)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tables.count {
            loadMore()
        }
    }
    
    func setCapacity(newMax: Int) {
        capacityFilter = newMax
    }
    
    @objc func onRefresh() {
        run(after: 1.3) {
            self.viewDidAppear(true)
            self.lobbyRefreshControl.endRefreshing()
        }
    }
    
    func run(after wait: TimeInterval, closure: @escaping() -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    func loadMore() {
        numberOfLoad = numberOfLoad + 5
        let query = PFQuery(className: "Tables")
        query.includeKey("host")
        query.whereKey("max", lessThanOrEqualTo: capacityFilter)
        query.limit = numberOfLoad
        
        query.findObjectsInBackground{ (tables, error) in
            if tables != nil {
                print("Retrieving tables data")
                self.tables = tables!
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let filterVc: FilterViewController = segue.destination as! FilterViewController
        filterVc.filterDataDelegate = self
        filterVc.maxFilter = capacityFilter
    }
}
