//
//  TableInfoViewController.swift
//  meat2eat
//
//  Created by Lam, An Q on 11/21/21.
//

import UIKit
import Parse

class TableInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, CALayerDelegate{
    
    @IBOutlet weak var MeetTimeLabel: UILabel!
    @IBOutlet weak var MeetDateLabel: UILabel!
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var RestaurantLocation: UILabel!
    @IBOutlet weak var HostnameLabel: UILabel!
    
    @IBOutlet weak var JoinButton: UIButton!
    
    @IBOutlet weak var FilledSlots: UILabel!
    

    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    @IBOutlet weak var TotalSlots: UILabel!
    var totalSlots_ = 12
    var filledSlots = 0;
    let tableId = "1zBlQfNccR"
    var table2Meet = [PFObject]()
    var userList = [PFUser]()
    var host = PFUser();
    
    /// <#Description#>
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        slotsCollectionView.delegate = self
        slotsCollectionView.dataSource = self
        //self.loadGuest()
        
        //slotsCollectionView.reloadData()
      
        // Do any additional setup after loading the view.*/
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
     
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return totalSlots_;
        }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTable2Eat()
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCollectionViewCell
         
         print("Load cell-------")
         print(indexPath.row)

            if(self.filledSlots > indexPath.row){
                do {
                    print("DDDDCELLLLLLLLLLLL")
                   
                    var user_ = PFUser();
                    if(indexPath.row == 0){
                        user_ = self.host
                    }else if(self.userList.isEmpty == false){
                        print("User________")
                        user_ = self.userList[indexPath.row-1]

                    }
                    print(user_)
                    let query = PFUser.query()
                    query?.whereKey("objectId", contains: user_.objectId)
                    var userInfo = try query?.findObjects() as! [PFUser]
                    
                    if(userInfo.isEmpty == false){
                       cell.UserName.text = userInfo[0]["username"] as? String
                        let imageFile = userInfo[0]["image"] as!PFFileObject
                        let urlString = imageFile.url!
                        let url = URL(string: urlString)!
                        cell.UserImage.af.setImage(withURL: url)
                    }
                } catch {
                    print(error)
                }
            }
            return cell
        }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func userInTableLoad(){
        let user = PFUser.current()
        //check if user is the host
        if( user?.objectId! == self.host.objectId!){
            self.JoinButton.isEnabled = false;
        }else{
            self.JoinButton.isEnabled = true;
            let userString = user?.objectId as! String
            let guestListId = self.table2Meet[0]["guestsId"] as! [String]
            if guestListId.contains(userString){
                self.JoinButton.setTitle("Leave", for: .normal)
                
            }else{
                self.JoinButton.setTitle("Join", for: .normal)
                
            }
        }
    }
    @IBAction func backOnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func loadTable2Eat(){
        
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("users")
        query.whereKey("objectId", contains: tableId)
        query.limit = 1
     
        query.findObjectsInBackground{(Table, error) in
                
            self.table2Meet = Table!
            let table = self.table2Meet[0]
            print("ttabkbk")
            print(table)
            self.host  = table["host"] as! PFUser
            if(table["guestsId"] != nil){
                self.userList = table["guestsId"] as! [PFUser]
            }
            self.filledSlots = self.userList.count + 1
            self.totalSlots_ = (table["slots"] as! Int) + 1
            
            self.HostnameLabel.text = "\(PFUser.current()?.username)'s"
            self.TotalSlots.text = "\(self.totalSlots_)"
            self.FilledSlots.text = "\(self.filledSlots)"
            self.RestaurantName.text = "\(table["ResName"] as! String)"
            self.RestaurantLocation.text = "\(table["location"] as! String)"
            self.MeetTimeLabel.text = "\(table["detailMeet"] as! String)"
            
            self.slotsCollectionView.reloadData()
            }
    }
       
}
