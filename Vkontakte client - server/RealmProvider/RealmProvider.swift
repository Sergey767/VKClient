//
//  RealmProvider.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 04.04.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider: Operation {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func get<T: Object>(_ type: T.Type, configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
}
