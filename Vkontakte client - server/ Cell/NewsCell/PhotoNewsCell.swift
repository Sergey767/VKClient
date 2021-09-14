//
//  PhotoNewsCell.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 03.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import UIKit

class PhotoNewsCell: UITableViewCell {
    
    static let reuseIdentifier = "PhotoNewsCell"
    
    @IBOutlet weak var imageAvatarNews: UIImageView!
    @IBOutlet weak var userNameNews: UILabel!
    @IBOutlet private weak var photoNews: UIImageView!
    @IBOutlet private weak var photoButtonView: VkButtons!
    @IBOutlet private weak var newsImageHeightConstraint: NSLayoutConstraint!
    
    
    func configure(with news: ItemsNews, ownerGroupNews: ItemsGroups?, ownerProfilesNews: ItemsProfiles?, photoHeight: CGFloat) {
        
        let urlPost = URL(string: news.photo)
        photoNews.kf.setImage(with: urlPost)
        photoButtonView.commentsLabel?.text = news.comments
        photoButtonView.likeLabel?.text = news.likes
        photoButtonView.repostLabel?.text = news.reposts
        photoButtonView.viewingLabel?.text = news.views
        newsImageHeightConstraint.constant = ceil(photoHeight)
    }
    

}
