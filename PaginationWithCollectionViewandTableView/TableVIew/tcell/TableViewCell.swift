//
//  TableViewCell.swift
//  PaginationWithCollectionViewandTableView
//
//  Created by Muhammad Abdullah Al Mamun on 11/10/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
