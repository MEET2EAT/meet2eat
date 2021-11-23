//
//  ProfileViewController.swift
//  meat2eat
//
//  Created by Airi Shimamura on 11/20/21.
//

import UIKit
import AlamofireImage
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameDisplay: UILabel!
    
    override func viewDidLoad() {
        

        
        makeRounded()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func makeRounded() {

        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.layer.cornerRadius =
        profilePic.frame.height / 2
        profilePic.clipsToBounds = true
     
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
