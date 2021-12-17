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
    var capacityFilter = 20
    var numberOfLoad: Int!
    let lobbyRefreshControl = UIRefreshControl()
    var tableId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        FilterViewController.instance.setListener(listener: self)
        
        lobbyRefreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = lobbyRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("host")
        query.whereKey("slots", lessThanOrEqualTo: capacityFilter)
        query.order(byDescending: "createdAt")
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
        let guestCount = (table["guestsId"] as AnyObject).count ?? 0
        let tableHost = table["host"] as! PFUser
        let imageFile = tableHost["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.restaurantNameLabel.text = table["ResName"] as? String
        cell.restaurantLocLabel.text = table["location"] as? String
        cell.currentLabel.text = "\(guestCount + 1)"
        cell.maxLabel.text = "\(table["slots"]!)"
        cell.tableImg.af_setImage(withURL: url)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTable = tables[indexPath.row]
        tableId = selectedTable.objectId
        performSegue(withIdentifier: "tableInfoSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // infinite scroll
        if indexPath.row + 1 == tables.count && tables.count >= 20 {
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
        numberOfLoad = numberOfLoad + 10
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("host")
        query.whereKey("slots", lessThanOrEqualTo: capacityFilter)
        query.order(byDescending: "createdAt")
        query.limit = numberOfLoad
        
        query.findObjectsInBackground{ (tables, error) in
            if tables != nil {
                print("Retrieving tables data")
                self.tables = tables!
                self.tableView.reloadData()
            }
        }
    }
    
    func filterDismissed() {
        run(after: 0.3) {
            self.viewDidAppear(true)
            self.lobbyRefreshControl.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "filterSegue" {
            let filterVc: FilterViewController = segue.destination as! FilterViewController
            filterVc.filterDataDelegate = self
            filterVc.maxFilter = capacityFilter
        } else if segue.identifier == "tableInfoSegue" {
            let infoVc = segue.destination as! TableInfoViewController
            infoVc.tableId = self.tableId
        }
    }
}
