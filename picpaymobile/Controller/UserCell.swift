//
//  UserCellTableViewCell.swift
//  picpaymobile
//
//  Created by Anderson Chagas on 01/05/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit

class UserCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var userPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userPhoto.layer.cornerRadius = 30
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

        // Configure the view for the selected state
    }
    
}
