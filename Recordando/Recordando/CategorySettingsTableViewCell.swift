//
//  CategorySettingsTableViewCell.swift
//  Recordando
//
//  Created by Bernardo Trevino on 11/3/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class CategorySettingsTableViewCell: UITableViewCell {
    
    var category: Categoria!
    @IBOutlet weak var lblCategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
