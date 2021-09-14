//
//  ItemsGroups.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 16.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemsGroups {
    let groupId: Int
    let nameGroup: String
    let photo: String
    let token: String
    
    init(json: JSON, token: String) {

        self.groupId = json["id"].intValue
        self.nameGroup = json["name"].stringValue
        self.photo = json["photo_50"].stringValue
        
        self.token = token
    }
}
