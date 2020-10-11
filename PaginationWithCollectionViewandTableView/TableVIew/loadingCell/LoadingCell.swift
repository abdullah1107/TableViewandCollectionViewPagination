//
//  LoadingCell.swift
//  PaginationWithCollectionViewandTableView
//
//  Created by Muhammad Abdullah Al Mamun on 11/10/20.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var activetyIndecator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //backgroundColor = UIColor.clear
        //activetyIndecator.color = UIColor.white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
