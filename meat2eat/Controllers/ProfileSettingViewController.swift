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
    @IBOutlet weak var passwordField: UITextField!
    
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

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func save(_ sender: Any) {
        let user = PFUser.current()!
            
        user["username"] = usernameField.text!
//        user["password"] = password.text!
    
        
        let imageData = profilePic.image!.pngData()
        let file = PFFileObject(name: "image.phg", data: imageData!)
        
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
