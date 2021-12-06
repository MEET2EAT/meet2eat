//
//  FilterViewController.swift
//  meat2eat
//
//  Created by Hew, Vincent on 11/28/21.
//

import UIKit

//Protocol used for send filter data back
protocol FilterDataDelegate: AnyObject {
    func setCapacity(newMax: Int)
}

class FilterViewController: UIViewController {

    @IBOutlet weak var capacityField: UITextField!
    var maxFilter = LobbyViewController().capacityFilter
    weak var filterDelegate: FilterDataDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capacityField.text = "\(maxFilter)"
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyBtn(_ sender: Any) {
        filterDelegate?.setCapacity(newMax: Int(capacityField.text!) ?? maxFilter)
        print(capacityField.text!)
        print(LobbyViewController().capacityFilter)
        
        
        
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
