//
//  SearchGroupCell.swift
//  Vkontakte
//
//  Created by Серёжа on 11/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit

class SearchGroupCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchGroupCell"
    
    @IBOutlet private weak var searchGroupName: UILabel!
    @IBOutlet weak var searchGroupImageView: UIImageView!
    
    func configure(with searchGroup: SearchGroup) {
        
        let name = searchGroup.name
        searchGroupName.text = name
    }
}
