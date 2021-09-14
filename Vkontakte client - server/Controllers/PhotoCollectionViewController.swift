//
//  MyPhotoCollectionViewController.swift
//  Vkontakte
//
//  Created by Серёжа on 29/06/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {
    let networkService = NetworkService()
    private lazy var photos = try? Realm().objects(Photo.self).filter("userId == %@", userId)
    private var notificationToken: NotificationToken?
    
    public var userId: Int?
    var friendTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userId = userId {
            networkService.fetchPhotos(for: userId) { [weak self] photos in
                try? RealmProvider.save(items: photos)
            }
        }
        
        notificationToken = photos?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.collectionView.reloadData()
            case .error(let error):
                self.show(error)
            }
        }
        
        self.title = friendTitle
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        guard let photo = photos?[indexPath.row] else { return cell }
        cell.configure(with: photo)
        
        return cell
    }
}
