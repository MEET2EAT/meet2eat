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
        //RestaurantsViewController .dismiss(animated:YES completion:nil)
      //  RestaurantsViewController.dismiss(animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }


    
    @IBAction func OnSetTableButton(_ sender: Any) {

       let Table2Meet = PFObject(className: "Table2Meet")
        
        Table2Meet["ResName"] = nameLabel.text!
        Table2Meet["location"] = location.text!
        Table2Meet["current"] = 0
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
       // HostViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func onBackButton(_ sender: Any) {
        // The object has been saved.
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
    
func doSomethingWith(data: Restaurant) {
    var addressFul = data.location["display_address"]! as! NSArray
    let x = addressFul[0] as! String
    let y = addressFul[1] as! String
    location.text =  x + y
    nameLabel.text = data.name
    }

}
