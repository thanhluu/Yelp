//
//  SelectCell.swift
//  Yelp
//
//  Created by Luu Tien Thanh on 2/24/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class SelectCell: UITableViewCell {

    @IBOutlet weak var selectLabel: UILabel!
    
    var delegate: SwitchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
