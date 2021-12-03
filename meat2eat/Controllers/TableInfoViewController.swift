//
//  TableInfoViewController.swift
//  meat2eat
//
//  Created by Lam, An Q on 11/21/21.
//

import UIKit
import Parse

class TableInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, CALayerDelegate{
    
    
    

    @IBOutlet weak var TableStatus: UILabel!
    @IBOutlet weak var TableApproved: UILabel!
    
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var RestaurantLocation: UILabel!
    
    @IBOutlet weak var FilledSlots: UILabel!
    

    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    @IBOutlet weak var TotalSlots: UILabel!
    let totalSlots_ = 9
    var filledSlots = 0;
    let tableId = "1zBlQfNccR"
    var table2Meet = [PFObject]()
    var userIdList = [String]()
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
    
    
    
    
    @IBAction func joinOnAction(_ sender: Any) {
        print("Join on Action-----------")
       
        
    }
    func saveUser(){
        
    }
    func loadInfoTable(){
               
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
        
        let query = PFQuery(className: "user")
       // query.includeKey("users"
        query.limit = 1
     
        query.findObjectsInBackground{(Table, error) in
                print("GET USER")
                print(Table)
            }
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCollectionViewCell
             print("Load cell-------")

         
         print(indexPath.row)
            if(self.filledSlots > indexPath.row){
                print((self.filledSlots > indexPath.row))

//                 let query = PFQuery(className: "User")
//                 query.includeKeys(["username", "image"])
//                 print("SEEIDDD")
//                 print(self.userIdList[indexPath.row])
//                 //query.whereKey("objectId", contains: self.userIdList[indexPath.row])
//                 query.limit = 1
             
                var query = PFUser.query()
        query!.whereKey("username", equalTo:"loc")
        
        do {
            let users: [PFObject] = try query?.findObjects() as! [PFObject]
            print(users)
        } catch {
            print(error)
        }
                
                
                
                query.findObjectsInBackground{(user_, error) in
                    //print("DDDDCELLLLLLLLLLLL")
                    //print(user_)
                       // var userOj =  [PFObject]()
                       // userOj = user_!
                      //  let userTuple = userOj[0]
                                          
                      //  cell.UserName.text = userTuple["username"] as? String
                        
                      //  let imageFile = userTuple["image"] as!PFFileObject
                      //  let urlString = imageFile.url!
                      //  let url = URL(string: urlString)!
                      //  cell.UserImage.af.setImage(withURL: url)
                        
                    }
                
                   //cell.UserImage.af_setImage(withURL: <#T##URL#>)
                    //cell.backgroundColor = UIColor.green
             }
        
            return cell
        }
    
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: //UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
   // {
   //     return CGSize(width: 50, height: 50)
    //}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func loadGuest(userId_: String) -> Array<String>{
        var userInfo = [String]()
        let query = PFQuery(className: "User")
        query.includeKey("users")
        query.whereKey("objectId", contains: userId_)
        query.limit = 1
     
        query.findObjectsInBackground{(user_, error) in
                let userOj = user_!
                let userTuple = userOj[0]
                userInfo[0] = userTuple["username"] as! String
                userInfo[1] = userTuple["image"] as! String
                self.filledSlots = self.userIdList.count
                print(self.filledSlots)
                self.slotsCollectionView.reloadData()
            }
        return userInfo
    }
    func loadTable2Eat(){
        
       
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("users")
        query.whereKey("objectId", contains: tableId)
        query.limit = 1
     
        query.findObjectsInBackground{(Table, error) in
                
                self.table2Meet = Table!
            
                let table = self.table2Meet[0]
                               
                self.userIdList = (table["guestsId"] as! [String]) ?? []
                self.filledSlots = self.userIdList.count
                print(self.filledSlots)
                self.slotsCollectionView.reloadData()
            }
        
       
    }
       
}
