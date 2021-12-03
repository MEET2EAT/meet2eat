//
//  TableInfoViewController.swift
//  meat2eat
//
//  Created by Lam, An Q on 11/21/21.
//

import UIKit
import Parse

class TableInfoViewController: UIViewController{
    
    
    

    @IBOutlet weak var TableStatus: UILabel!
    @IBOutlet weak var TableApproved: UILabel!
    
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var RestaurantLocation: UILabel!
    
    @IBOutlet weak var FilledSlots: UILabel!
    

    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    @IBOutlet weak var TotalSlots: UILabel!
    let totalSlots_ = 9
    let filledSlots = 0;
    let tableId = "1zBlQfNccR"
    var table2Meet = [PFObject]()

    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
        slotsCollectionView.delegate = self
        slotsCollectionView.dataSource = self
        loadGuest()
   
        // Do any additional setup after loading the view.*/
    }
    
    @IBAction func joinOnAction(_ sender: Any) {
        print("Join on Action-----------")
        loadGuest()
        //print(self.table2Meet)
        
        let table = self.table2Meet[0]
        print(table)
        
        let guestsID = (table["guestsId"] as! [String]) ?? []
        print(guestsID[0])
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
    
    func loadGuest(){
        
       
        let query = PFQuery(className: "Table2Meet")
        query.includeKey("users")
        query.whereKey("objectId", contains: tableId)
        query.limit = 1
     
        query.findObjectsInBackground{(Table, error) in
                
                self.table2Meet = Table!
                self.slotsCollectionView.reloadData()
            }
        
       
    }
        
         
    
}


extension TableInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, CALayerDelegate{
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return totalSlots_;
        }
        
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCollectionViewCell
            
            //cell.UserImage.af_setImage(withURL: <#T##URL#>)
            cell.UserName.text = "Ikemen Kuma"
            //cell.backgroundColor = UIColor.green
            return cell
        }
    
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: //UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
   // {
   //     return CGSize(width: 50, height: 50)
    //}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
}
