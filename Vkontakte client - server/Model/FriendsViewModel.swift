//
//  FriendsViewModel.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 18.10.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import PromiseKit

class FriendsViewModel {
    
    private var networkService = NetworkService()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func launchPromiseFriendsChain() {

        firstly {
            networkService.getPromiseFriends(token: Singleton.instance.token)
        }
            .get { [weak self] friends in
                try? RealmProvider.save(items: friends)
            }
            .catch { error in
                print(error)
            }
            .finally {
            }
    }
}
