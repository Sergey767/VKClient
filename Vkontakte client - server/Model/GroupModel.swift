//
//  GroupModel.swift
//  Vkontakte
//
//  Created by Серёжа on 12/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var token: String = ""

    convenience init(_ json: JSON, token: String) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_50"].stringValue

        self.token = token
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}

//{
//    "id": 11069256,
//    "name": "УлГТУ. Официальная группа",
//    "screen_name": "univer.ulstu",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun7-8.userapi.com/c858128/v858128773/66fc7/enSwKmhN4js.jpg?ava=1",
//    "photo_100": "https://sun7-7.userapi.com/c858128/v858128773/66fc6/gdBZmSFlYoo.jpg?ava=1",
//    "photo_200": "https://sun7-8.userapi.com/c858128/v858128773/66fc5/DnvUj1jb5Fk.jpg?ava=1"
//}
