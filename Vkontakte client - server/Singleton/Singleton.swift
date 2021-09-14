//
//  Singleton.swift
//  Vkontakte
//
//  Created by Сергей on 07.11.2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import Foundation

class Singleton {

    public static let instance = Singleton()
    
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    var nextFrom: String = ""
    
}
