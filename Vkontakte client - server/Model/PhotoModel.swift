//
//  PhotoModel.swift
//  Vkontakte
//
//  Created by Сергей on 22.11.2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var urlString: String = ""
    @objc dynamic var width: Double = 0.0
    @objc dynamic var height: Double = 0.0
    @objc dynamic var userId: Int = 0
    
    var friends = LinkingObjects(fromType: User.self, property: "photos")
    
    convenience init(_ json: JSON, userId: Int) {
        self.init()
        self.id = json["id"].intValue
        let sizes = json["sizes"].arrayValue
        if let zSizes = sizes.filter ({ $0["type"] == "z" }).first {
            self.urlString = zSizes["url"].stringValue
        } else {
            self.urlString = json["sizes"][0]["url"].stringValue
        }
        
        self.width = json["sizes"][0]["width"].doubleValue
        self.height = json["sizes"][0]["height"].doubleValue
        
        self.userId = userId
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//{

//    "album_id": -6,
//    "owner_id": 206400980,
//    "sizes": [
//        {
//            "type": "m",
//            "url": "https://sun9-24.userapi.com/c850428/v850428074/efcab/B_WJBI9cdEY.jpg",
//            "width": 130,
//            "height": 130
//        },
//        {
//            "type": "o",
//            "url": "https://sun9-51.userapi.com/c850428/v850428074/efcaf/32oNJDM2R4A.jpg",
//            "width": 130,
//            "height": 130
//        },
//        {
//            "type": "p",
//            "url": "https://sun9-45.userapi.com/c850428/v850428074/efcb0/Gxp8oCvAlmg.jpg",
//            "width": 200,
//            "height": 200
//        },
//        {
//            "type": "q",
//            "url": "https://sun9-62.userapi.com/c850428/v850428074/efcb1/IDFXgbBWGYw.jpg",
//            "width": 320,
//            "height": 320
//        },
//        {
//            "type": "r",
//            "url": "https://sun9-17.userapi.com/c850428/v850428074/efcb2/8Exz6Y8hq3E.jpg",
//            "width": 510,
//            "height": 510
//        },
//        {
//            "type": "s",
//            "url": "https://sun9-50.userapi.com/c850428/v850428074/efcaa/hQhuk-o-TdU.jpg",
//            "width": 75,
//            "height": 75
//        },
//        {
//            "type": "x",
//            "url": "https://sun9-22.userapi.com/c850428/v850428074/efcac/tMO9NZAp41E.jpg",
//            "width": 604,
//            "height": 604
//        },
//        {
//            "type": "y",
//            "url": "https://sun9-66.userapi.com/c850428/v850428074/efcad/twllGo7QAEA.jpg",
//            "width": 807,
//            "height": 807
//        },
//        {
//            "type": "z",
//            "url": "https://sun9-66.userapi.com/c850428/v850428074/efcae/WECTyOLywNY.jpg",
//            "width": 1080,
//            "height": 1080
//        }
//    ],
//    "text": "",
//    "date": 1554136798,
//    "post_id": 1477
//}
