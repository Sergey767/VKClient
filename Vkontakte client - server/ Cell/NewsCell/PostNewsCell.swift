//
//  PostNewsCell.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 03.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import UIKit
import Kingfisher

class PostNewsCell: UITableViewCell {
    
    static let reuseIdentifier = "PostNewsCell"
    
    @IBOutlet weak var imageAvatarNews: UIImageView!
    @IBOutlet weak var userNameNews: UILabel!
    @IBOutlet private weak var postNewsLabel: UILabel!
    @IBOutlet private weak var postButtonView: VkButtons!
    @IBOutlet weak var btnExpandCollepse: UIButton!
    @IBOutlet weak var constraintBtnHeight: NSLayoutConstraint!
    
    @IBAction func onExpandCollepse(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if !sender.isSelected {
            btnExpandCollepse.setTitle("Показать полностью...", for: UIControl.State.normal)
            self.constraintBtnHeight.constant = 200
        } else {
            btnExpandCollepse.setTitle("Свернуть", for: UIControl.State.normal)
            self.constraintBtnHeight.constant = 500
        }
    }
    
    func configure(with news: ItemsNews, ownerGroupNews: ItemsGroups?, ownerProfilesNews: ItemsProfiles?) {
        postNewsLabel.text = news.text
        postButtonView.commentsLabel?.text = news.comments
        postButtonView.likeLabel?.text = news.likes
        postButtonView.repostLabel?.text = news.reposts
        postButtonView.viewingLabel?.text = news.views
    }
    
}
