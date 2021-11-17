//
//  TableCell.swift
//  meat2eat
//
//  Created by Hew, Vincent on 11/16/21.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var tableImg: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantLocLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
