//
//  HostViewController.swift
//  meat2eat
//
//  Created by Luu, Loc on 11/27/21.
//

import UIKit
import AlamofireImage
import Parse

class HostViewController: UIViewController,DisplayViewControllerDelegate {

    // Initialize restaurant variable
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var slots: UITextField!
    @IBOutlet weak var dateMeet: UIDatePicker!
    @IBOutlet weak var detailMeet: UITextField!

    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkHost()
    }

    @IBAction func OnSetTableButton(_ sender: Any) {
        
        let Table2Meet = PFObject(className: "Table2Meet")
        if nameLabel.text!.isEmpty || location.text!.isEmpty || detailMeet.text!.isEmpty {
            print("Missing Input Data")
            let alert = UIAlertController(title: "Missing Information", message: "The Restaurant, date, and destription cannot be empty. Please try again.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Table2Meet["ResName"] = nameLabel.text!
            Table2Meet["location"] = location.text!
            Table2Meet["slots"] = Int(slots.text!)
            Table2Meet["dateMeet"] = dateMeet.date
            Table2Meet["detailMeet"] = detailMeet.text!
            Table2Meet["host"] = PFUser.current()!
            
            Table2Meet.saveInBackground { (succeeded, error)  in
                if (succeeded) {
                    // The object has been saved.
                    self.dismiss(animated: true, completion: nil)
                    print("Saved")
                } else {
                    // There was a problem, check error.description
                    print("error!")
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let displayVC = segue.destination as! RestaurantsViewController
        displayVC.delegate = self
    }
    
    func checkHost() {
        let host = PFUser.current()!
        
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("host")
        query.whereKey("host", equalTo: host)
        query.findObjectsInBackground{ (found, error) in
            if found != nil {
                print(found)
                if found! != [] {
                    let alert = UIAlertController(title: "Host Restriction", message: "Each user can only host one table. Please close your previous table before creating new table.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
                    self.dismiss(animated: true, completion: nil)
                    self.present(alert, animated: true, completion: nil)
                }
            } else{
                print(error?.localizedDescription)
            }
        }
    }

    func doSomethingWith(data: Restaurant) {
        var addressFul = data.location["display_address"]! as! NSArray
        let x = addressFul[0] as! String
        let y = addressFul[1] as! String
        location.text =  x + y
        nameLabel.text = data.name
    }

}
