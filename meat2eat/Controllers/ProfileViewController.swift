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
    @IBOutlet weak var passwordDisplay: UILabel!
    @IBOutlet weak var emailDisplay: UILabel!
   
    
    override func viewDidLoad() {
        makeRounded()
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        usernameDisplay.text = PFUser.current()!.username
        passwordDisplay.text = "*****"
        emailDisplay.text = PFUser.current()!.email
        //phoneNumDisplay.text = PFUser.current()!.phone
        
        let user = PFUser.current()!
        let imageFile = user["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        profilePic.af_setImage(withURL: url)
    }
    
    
    func makeRounded() {
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
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
