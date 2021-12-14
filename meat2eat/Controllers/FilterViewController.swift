//
//  FilterViewController.swift
//  meat2eat
//
//  Created by Hew, Vincent on 11/28/21.
//

import UIKit

protocol filterDelegate: NSObjectProtocol {
    func setCapacity(newMax: Int)
    func filterDismissed()
}

class FilterViewController: UIViewController {
    
    class var instance: FilterViewController {
        struct Static {
            static let instance: FilterViewController = FilterViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var capacityField: UITextField!
    var maxFilter = 20
    weak var filterDataDelegate: filterDelegate?
    private var listener: filterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capacityField.text = "\(maxFilter)"
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyBtn(_ sender: Any) {
        if Int(capacityField.text!)! <= 50 && Int(capacityField.text!)! >= 2 {
            if let filterDataDelegate = filterDataDelegate {
                filterDataDelegate.setCapacity(newMax: Int(capacityField.text!) ?? maxFilter)
            }
            FilterViewController.instance.sendfilterDismissed(modelChanged: true)
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Invalid Filter", message: "The valid maximum capacity is between 2 to 50. Please try again.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setListener(listener: filterDelegate) {
        self.listener = listener
    }
    
    func sendfilterDismissed(modelChanged: Bool) {
        listener?.filterDismissed()
    }
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        }
    }
    */
}
