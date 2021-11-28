//
//  HostViewController.swift
//  meat2eat
//
//  Created by Luu, Loc on 11/27/21.
//

import UIKit
import AlamofireImage
class HostViewController: UIViewController {
    // Initialize restaurant variable
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var slots: UITextField!
    @IBOutlet weak var dateMeet: UIDatePicker!
    @IBOutlet weak var detailMeet: UITextField!

    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
      //  RestaurantsViewController.dismiss(animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }
    func configureOutlets() {
        if(r != nil){
            nameLabel.text = " Restaurant: " + r.name
            var addressFul = r.location["display_address"]! as! NSArray
            let x = addressFul[0] as! String
            let y = addressFul[1] as! String
            location.text = "Location:  " + x + y

        }
    }


    @IBAction func OnSetTableButton(_ sender: Any) {
       let Table2Meet = PFObject(className: "Table2Meet")
       if(r != nil){ 
            Table2Meet["ResName"] = r.name
            Table2Meet["ResImage"] = r.imageURL!
            ///.af.setImage(withURL: r.imageURL!)
            var addressFul = r.location["display_address"]! as! NSArray
            let x = addressFul[0] as! String
            let y = addressFul[1] as! String
            Table2Meet["location"] = x + y
        }
        Table2Meet["current"] = 0
        Table2Meet["slots"] = slots.text!
        Table2Meet["dateMeet"] = dateMeet.text!
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
    
    @IBAction func onBackButton(_ sender: Any) {
        // The object has been saved.
        self.dismiss(animated: true, completion: nil)
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
