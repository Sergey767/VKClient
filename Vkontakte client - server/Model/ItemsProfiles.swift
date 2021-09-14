//
//  ItemsProfiles.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 16.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemsProfiles {
    let profilesId: Int
    let firstName: String
    let lastName: String
    let photo: String
    let token: String
    
    init(json: JSON, token: String) {
        self.profilesId = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = json["photo_50"].stringValue
        
        self.token = token
    }
}
