//
//  UserModel.swift
//  Vkontakte
//
//  Created by Серёжа on 12/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var token: String = ""
    
    let photos = List<Photo>()
    
    convenience init(_ json: JSON, token: String) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.avatar = json["photo_50"].stringValue
        self.online = json["online"].intValue
        self.photos.append(objectsIn: photos)
        
        self.token = token
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//{
//    "id": 17675140,
//    "first_name": "Ольга",
//    "last_name": "Шипунова",
//    "is_closed": false,
//    "can_access_closed": true,
//    "nickname": "",
//    "photo_50": "https://sun1-15.userapi.com/c851420/v851420155/151054/2SSzH7NBhio.jpg?ava=1",
//    "photo_100": "https://sun1-17.userapi.com/c851420/v851420155/151053/BxWZKzu5ygY.jpg?ava=1",
//    "photo_200_orig": "https://sun1-84.userapi.com/c855324/v855324155/798f4/oghUDLyF2Sg.jpg?ava=1",
//    "online": 1,
//    "track_code": "929a6885RSjDzAn7O-iT8Wwi0f-_kSKvwOxWnMm9U0bbGCnpzG4kS_L2Aa87vpPzWK1XLaDxL7jb"
//}

