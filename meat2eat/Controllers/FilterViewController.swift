//
//  FilterViewController.swift
//  meat2eat
//
//  Created by Hew, Vincent on 11/28/21.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var capacityField: UITextField!
    var maxFilter = LobbyViewController().capacityFilter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capacityField.text = "\(maxFilter)"
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyBtn(_ sender: Any) {
        
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
