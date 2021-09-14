//
//  ItemsNews.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 11.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemsNews {
    let sourceId: Int
    let text: String
    let photo: String
    let photoHeight: Int
    let photoWidth: Int
    let comments: String
    let likes: String
    let reposts: String
    let views: String
    let token: String
    
    init(json: JSON, token: String) {
        self.sourceId = json["source_id"].intValue
        self.text = json["text"].stringValue
        self.photo = json["attachments"][0]["photo"]["sizes"][0]["url"].stringValue
        self.photoHeight = json["attachments"][0]["photo"]["sizes"][0]["height"].intValue
        self.photoWidth = json["attachments"][0]["photo"]["sizes"][0]["width"].intValue
        self.comments = json["comments"]["count"].stringValue
        self.likes = json["likes"]["count"].stringValue
        self.reposts = json["reposts"]["count"].stringValue
        self.views = json["views"]["count"].stringValue
        
        self.token = token
    }
}

