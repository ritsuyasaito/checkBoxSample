//
//  CustomTableViewCell.swift
//  checkBoxSample
//
//  Created by 齋藤律哉 on 2020/05/31.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import BEMCheckBox

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var checkBox: BEMCheckBox!
    @IBOutlet var sampleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkBox.boxType = .square
        checkBox.animationDuration = 0.1
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
