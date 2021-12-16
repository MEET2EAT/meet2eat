//
//  TableInfoViewController.swift
//  meat2eat
//
//  Created by Lam, An Q on 11/21/21.
//

import UIKit
import Parse
import ParseLiveQuery


//let liveQueryClient = ParseLiveQuery.Client()

class TableInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, CALayerDelegate{
    
    @IBOutlet weak var MeetDateLabel: UILabel!
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var RestaurantLocation: UILabel!
    @IBOutlet weak var HostnameLabel: UILabel!
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var FilledSlots: UILabel!
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    @IBOutlet weak var TotalSlots: UILabel!
    var totalSlots_ = 12
    var filledSlots = 0
    var tableId: String!
    var table2Meet = [PFObject]()
    var userList = [PFUser]()
    var host = PFUser()
    
    @IBOutlet weak var dateLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotsCollectionView.delegate = self
        slotsCollectionView.dataSource = self
        //self.loadGuest()
        //slotsCollectionView.reloadData()
        dateLable.layer.position.y = MeetDateLabel.layer.position.y
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
         cell.UserName.text = "Empty"
                  
         let x = UIImage(named: "KumaProfilePicture")
        // let xURL = Bundle.main.url(forResource: "KumaProfilePicture", withExtension: "png")
         cell.UserImage.image = x

         // print("Load cell-------")
         //print(indexPath.row)
         
            if(self.filledSlots > indexPath.row){
                    //print("DDDDCELLLLLLLLLLLL")
                    var user_ = PFUser();
                    if(indexPath.row == 0){
                        user_ = self.host
                    }else if(self.userList.isEmpty == false){
                        //print("User________")
                        user_ = self.userList[indexPath.row-1]
                    }
                   
                    let query = PFUser.query()
                    
                    query?.whereKey("objectId", contains: user_.objectId)
                    
                    query?.findObjectsInBackground(){(userInfo, error) in
                        if userInfo != nil {
                            if(indexPath.row == 0){
                                let hostName = (userInfo?[0]["username"] as? String)
                                let hostTable = hostName! + "'s"
                                self.HostnameLabel.text =  hostTable
                            }
                            if(userInfo?.isEmpty == false){
                                cell.UserName.text = userInfo?[0]["username"] as? String
                                let imageFile = userInfo?[0]["image"] as!PFFileObject
                                let urlString = imageFile.url!
                                let url = URL(string: urlString)!
                                cell.UserImage.af.setImage(withURL: url)
                               
                            }
                        }else{
                            print("something wrong")
                        }
                        
                    }
                
            }
            return cell
        }
    
    @IBAction func botButtonOnAction(_ sender: UIButton) {
        //print("BUTONONONONONO")
        print(sender.titleLabel?.text ?? "Empty")
        let buttonTitle = sender.titleLabel?.text ?? "Empty"
        if(buttonTitle == "Cancel"){
           // print("Cancellllllllllllll")
           //cancel the table
            self.table2Meet[0].deleteInBackground(){ (success, error) in
                if success {
                    print("Deleted")
                }else{
                    print("something wrong")
                }
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            if (buttonTitle == "Leave"){
               //leave table
                //print("Leaveeeeeeeeeeee")
                self.table2Meet[0].remove(PFUser.current() as Any, forKey: "guestsId")
                self.table2Meet[0].saveInBackground(){(success, error) in
                    if success {
                        print("saved")
                      //  let subscription: Subscription<PFObject> = Client.shared.subscribe(table2Meet[0])
                        self.viewDidAppear(true)
                    }else{
                        print("something wrong")
                    }
                }
               
            }else if (buttonTitle == "Join"){
                //Join table
               // print("JOINNNNNNNNNNN")
                print(PFUser.current() as! PFUser)
                self.table2Meet[0].add(PFUser.current() as! PFUser, forKey: "guestsId")
                self.table2Meet[0].saveInBackground(){(success, error) in
                    if success {
                        print("saved")
                        self.viewDidAppear(true)
                    }else{
                        print("something wrong")
                    }

                }
                //loadTable2Eat()
                
            }
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    @IBAction func backOnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadTable2Eat(){
        
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("users")
        query.whereKey("objectId", contains: tableId!)
        query.limit = 1
        
        query.findObjectsInBackground{(Table, error) in
                
            self.table2Meet = Table!
            let table = self.table2Meet[0]
            //print("ttabkbk")
            // print(table)
            self.host  = table["host"] as! PFUser
            if(table["guestsId"] != nil){
                self.userList = table["guestsId"] as! [PFUser]
            }
            self.filledSlots = self.userList.count + 1
            self.totalSlots_ = (table["slots"] as! Int)
    
            self.TotalSlots.text = "\(self.totalSlots_)"
            self.FilledSlots.text = "\(self.filledSlots)"
            self.RestaurantName.text = "\(table["ResName"] as! String)"
            self.RestaurantLocation.text = "\(table["location"] as! String)"
     
            let meetDate = table["dateMeet"] as! Date
            let dateFort = DateFormatter()
            dateFort.dateFormat = "EEEE MM/dd/yyyy HH:mm"
            let myDate = dateFort.string(from: meetDate)
            self.MeetDateLabel.text = myDate
            self.slotsCollectionView.reloadData()
            //self.loadButton()
            
            let user = PFUser.current()
            //check if user is the host
            if(user?.objectId! == self.host.objectId!){
                self.JoinButton.setTitle("Cancel", for: .normal)
            }else{
                self.JoinButton.isEnabled = true;
                let userString = user?.objectId as! String
                if(self.table2Meet[0]["guestsId"]  != nil){
                    //print("GUEST LIST IS NOT EMPTY")
                    let guestList = self.table2Meet[0]["guestsId"] as! [PFUser]
                    var isAguest = false;
                    for guest in guestList {
                        if guest.objectId == userString{
                            self.JoinButton.setTitle("Leave", for: .normal)
                            isAguest = true;
                            break;
                        }
                    }
                    if isAguest == false {
                        self.JoinButton.setTitle("Join", for: .normal)
                    }
                  
                }
                else{
                   // print("GUEST LIST IS EMPTY")
                    self.JoinButton.setTitle("Join", for: .normal)
                }
            }
        }
    }
}
