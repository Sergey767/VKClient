//
//  SearchGroupModel.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 01.03.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class SearchGroup: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var searchQuery: String = ""

    convenience init(_ json: JSON, searchQuery: String) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_50"].stringValue
        
        self.searchQuery = searchQuery
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//{
//    "id": 43001537,
//    "name": "Apple | iPhone | iPad",
//    "screen_name": "apple.inside",
//    "is_closed": 0,
//    "type": "page",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun7-8.userapi.com/c855328/v855328079/d9f63/we5d1A6k6Xc.jpg?ava=1",
//    "photo_100": "https://sun7-8.userapi.com/c855328/v855328079/d9f62/jmcmQn_jC4A.jpg?ava=1",
//    "photo_200": "https://sun7-6.userapi.com/c855328/v855328079/d9f61/rgprabkMhmk.jpg?ava=1"
//}
