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
    var totalSlots_ = 12
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
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCollectionViewCell
             print("Load cell-------")

         
         print(indexPath.row)
            if(self.filledSlots > indexPath.row){
                print((self.filledSlots > indexPath.row))

             
                let query = PFUser.query()
                query!.whereKey("objectId", equalTo: self.userIdList[indexPath.row])
                print(self.userIdList[indexPath.row])
                do {
                    let user_ = try query?.findObjects() as! [PFObject]

                    print("DDDDCELLLLLLLLLLLL")
                    print(user_)
                    if(user_.isEmpty == false){
                        let userTuple = user_[0]

                        cell.UserName.text = userTuple["username"] as? String

                        let imageFile = userTuple["image"] as!PFFileObject
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
            self.userIdList = (table["guestsId"] as! [String])
                self.filledSlots = self.userIdList.count
            self.totalSlots_ = (table["slots"] as! Int)
                print(self.filledSlots)
                
            self.TotalSlots.text = "\(self.totalSlots_)"
            self.FilledSlots.text = "\(self.userIdList.count)"
                self.RestaurantName.text = "\(table["ResName"] as! String)"
            self.RestaurantLocation.text = "\(table["location"] as! String)"
            self.TableApproved.text = "\(table["detailMeet"] as! String)"
        
            self.slotsCollectionView.reloadData()
            }
        
       
    }
       
}
