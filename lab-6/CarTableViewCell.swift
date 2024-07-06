//
//  CarTableViewCell.swift
//  lab-6
//
//  Created by user252704 on 7/5/24.
//

import UIKit

class CarTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var details: UILabel!
}
