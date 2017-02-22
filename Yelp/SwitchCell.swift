//
//  SwitchCell.swift
//  Yelp
//
//  Created by Luu Tien Thanh on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didChangedValue value: Bool)
}
class SwitchCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    var delegate: SwitchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        print("switch changed to \(sender.isOn)")
        delegate.switchCell(switchCell: self, didChangedValue: sender.isOn)
    }

}
