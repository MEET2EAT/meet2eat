//
//  TableInfoCollectionViewController.swift
//  meat2eat
//
//  Created by Lam, An Q on 12/2/21.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

class TableInfoCollectionViewController: UICollectionViewController{

    @IBOutlet weak var TableStatus: UILabel!
   
    @IBOutlet weak var TableApproved: UILabel!
     
    @IBOutlet weak var RestaurantName: UILabel!
    
    @IBOutlet weak var RestaurantLocation: UILabel!
    
    @IBOutlet weak var FilledSlots: UILabel!
    
    @IBOutlet weak var TotalSlots: UILabel!
    
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    let totalSlots_ = 9
    var filledSlots = 0;
    let tableId = "1zBlQfNccR"
    var table2Meet = [PFObject]()
    var userIdList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        slotsCollectionView.delegate = self
        slotsCollectionView.dataSource = self
        self.loadGuest()
        slotsCollectionView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    @IBAction func JoinOnAcction(_ sender: Any) {
    }
    
    func loadGuest(){
       
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("disappear")
        self.loadGuest()
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCollectionViewCell
           //  print(indexPath)
               
        cell.UserName.text = self.userIdList[indexPath.row]
           //cell.UserImage.af_setImage(withURL: T##URL)
         
           //cell.backgroundColor = UIColor.green
           return cell
       }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
