//
//  PostViewController.swift
//  meat2eat
//
//  Created by Luu, Loc on 11/16/21.
//

import UIKit
import AlamofireImage
import Parse

protocol postDelegate: NSObjectProtocol {
    func postDismissed()
}

class PostViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    class var instance: PostViewController {
        struct Static {
            static let instance: PostViewController = PostViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageInputAlert: UILabel!
    private var listener: postDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = commentField.text!
        let imageData = imageView.image!.pngData()
        
        let x = UIImage(named: "image_placeholder")
        
        if(imageData == x!.pngData()){
            imageInputAlert.text = "Please Add Image!!!"
            print("add image")
        }else{
            let file = PFFileObject(name:"image.png",data: imageData!)
            post["image"] = file
            post["author"] = PFUser.current()!
            //change back to this after have user account
            post.saveInBackground { (succeeded, error)  in
                if (succeeded) {
                    // The object has been saved.
                    PostViewController.instance.sendpostDismissed(modelChanged: true)
                    self.dismiss(animated: true, completion: nil)
                    print("Saved")
                } else {
                    // There was a problem, check error.description
                    print("error!")
                }
            }
        }
    }
    //click on the image place
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            
        }else{
            picker.sourceType = .photoLibrary
            
        }
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        //resize import alamo
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        // The object has been saved.
        self.dismiss(animated: true, completion: nil)
    }
    
    func setListener(listener: postDelegate) {
        self.listener = listener
    }
    
    func sendpostDismissed(modelChanged: Bool) {
        listener?.postDismissed()
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
