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
    
    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
        slotsCollectionView.delegate = self
        slotsCollectionView.dataSource = self
        //let flowLayout = UICollectionViewFlowLayout()
        //Create empty view cells
        
        
        /*self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SlotCell")
        collectionView.layer.delegate = self
        collectionView.dataSource = self
                collectionView.backgroundColor = UIColor.cyan
        self.view.addSubview(collectionView)
        
        // Do any additional setup after loading the view.*/
    }
    
    func loadInfoTable(){
        let Table2Meet = PFObject(className:"Table2Meet")
        
        let user = PFUser.current()
        
        if(user){
            print(user.getstring())
        }
       
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
