//
//  HostViewController.swift
//  meat2eat
//
//  Created by Luu, Loc on 11/27/21.
//

import UIKit
import AlamofireImage
class HostViewController: UIViewController {
    // Initialize restaurant variable
    @IBOutlet weak var nameLabel: UILabel!
    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()

        // Do any additional setup after loading the view.
    }
    func configureOutlets() {
        nameLabel.text = r?.name
        print(nameLabel.text)
//        reviewsLabel.text = String(r.reviews)
//        starImage.image = Stars.dict[r.rating]!
//        headerImage.af.setImage(withURL: r.imageURL!)
//
//        // Extra: Add tint opacity to image to make text stand out
//        let tintView = UIView()
//        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3) //change to your liking
//        tintView.frame = CGRect(x: 0, y: 0, width: headerImage.frame.width, height: headerImage.frame.height)
//
//        headerImage.addSubview(tintView)
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
