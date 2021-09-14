//
//  MyGroupsCell.swift
//  Vkontakte
//
//  Created by Серёжа on 11/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import Kingfisher

class MyGroupsCell: UITableViewCell {
    
    static let reuseIdentifier = "MyGroupsCell"
    
    @IBOutlet private weak var groupsName: UILabel!
    @IBOutlet weak var myGroupsImageView: UIImageView!
    
    func configure(with group: Group) {
        
        let name = group.name
        groupsName.text = name
        
        let url = URL(string: group.photo)
        myGroupsImageView.kf.setImage(with: url)
        myGroupsImageView.layer.cornerRadius = myGroupsImageView.frame.size.width / 2
        myGroupsImageView.clipsToBounds = true
    }
}
