//
//  VKNews.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 11.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation

class VKNews {
    var items: [ItemsNews]
    var profiles: [ItemsProfiles]
    var groups: [ItemsGroups]
    
    init(items: [ItemsNews], profiles: [ItemsProfiles], groups: [ItemsGroups]) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
    }
}
