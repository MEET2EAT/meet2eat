//
//  LobbyViewController.swift
//  meat2eat
//
//  Created by Hew, Vincent on 11/13/21.
//

import UIKit
import Parse
import AlamofireImage

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tables = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // unit 5 video parstagram 6
        // className and includeKey might need to adjust
        let query = PFQuery(className: "Tables")
        query.includeKey("host")
        query.limit = 20
        
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
        cell.restaurantLocLabel.text = table["restaurantLoc"] as? String     // location is array ** need to change it later
        cell.currentLabel.text = table["current"] as? String
        cell.maxLabel.text = table["max"] as? String
        
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
