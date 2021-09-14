//
//  FriendsCell.swift
//  Vkontakte
//
//  Created by Серёжа on 10/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import Kingfisher

class MyFriendsCell: UITableViewCell {
    
    static let reuseIdentifier = "MyFriendsCell"
    
    @IBOutlet private weak var friendsName: UILabel!
    @IBOutlet private weak var imageAvatar: UIImageView!
    
    let instetsImageX: CGFloat = 20
    let instetsY: CGFloat = 14.5
    let instetsLabelRightX: CGFloat = 74
    let instetsLabelLeftX: CGFloat = 85
    
    override func layoutSubviews() {
        friendsNameLabelFrame()
        imageAvatarFrame()
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        
        let maxWidth = bounds.width - instetsLabelLeftX - instetsLabelRightX
        
        let textBlockSize = CGSize(
            width: maxWidth,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        let curText = text as NSString
        
        let rect = curText.boundingRect(
            with: textBlockSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        
        let size = CGSize(width: ceil(width), height: ceil(height))
        
        return size
    }
    
    func friendsNameLabelFrame() {
        let friendsNameLabelSize = getLabelSize(
            text: friendsName.text ?? "",
            font: friendsName.font
        )
        
        let friendsNameLabelOrigin = CGPoint(x: instetsLabelLeftX, y: instetsY)
        
        friendsName.frame = CGRect(origin: friendsNameLabelOrigin, size: friendsNameLabelSize)
    }
    
    func imageAvatarFrame() {
        let imageSideLength: CGFloat = 25
        let imageSize = CGSize(width: imageSideLength, height: imageSideLength)
        let origin = CGPoint(x: instetsImageX, y: instetsY)
        imageAvatar.frame = CGRect(origin: origin, size: imageSize)
    }
    
    func configure(with friend: User) {
        
        let name = friend.firstName + " " + friend.lastName
        setFriendsName(text: name)
        
        let url = URL(string: friend.avatar)
        imageAvatar.kf.setImage(with: url)
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width / 2
        imageAvatar.clipsToBounds = true
    }
    
    private func setFriendsName(text: String) {
        friendsName.text = text
        friendsNameLabelFrame()
    }
}
