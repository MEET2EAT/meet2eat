//
//  ProfileSettingViewController.swift
//  meat2eat
//
//  Created by Airi Shimamura on 11/21/21.
//

import UIKit
import AlamofireImage
import Parse

class ProfileSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    
  
    override func viewDidLoad() {
        makeRounded()
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usernameField.text = PFUser.current()?.username
        //oldPasswordField.text = PFUser.current()?.password
        
        let user = PFUser.current()!
        let imageFile = user["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        profilePic.af_setImage(withURL: url)
    }
    
    // circle profile pic
    func makeRounded() {
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.layer.cornerRadius =
        profilePic.frame.height / 2
        profilePic.clipsToBounds = true
        }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func save(_ sender: Any) {
        let user = PFUser.current()!
            
        user["username"] = usernameField.text
        user["email"] = emailField.text
        
        // chnage password
        if oldPasswordField.hasText {
            user["password"] = oldPasswordField.text
            print("password changed to \(oldPasswordField.text)")
                
        }
        else  {
            // print error message
            let alert = UIAlertController(title: "Error", message: "Re Enter New Password", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            print("chaing password failed")
        }
        
        
        let imageData = profilePic.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        user["image"] = file
        
        user.saveInBackground{(success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }else{
                print("error!")
            }
        }
    }

    @IBAction func changePic(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        profilePic.image = scaledImage
        dismiss(animated: true, completion: nil)
        
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
