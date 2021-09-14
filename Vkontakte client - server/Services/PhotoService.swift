//
//  PhotoService.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 13.10.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import Alamofire

class PhotoService {
    
    private var images = [String: UIImage]()
    
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return session
    }()
    
    private static let pathName: String = {
        let pathName = "Images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return pathName
        }
        
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        
        return pathName
    }()
    
    private let cachesLifeTime: TimeInterval = 500
    
    private var container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(tableView: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collectionView: container)
    }
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let hashName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData()
        else {
            return
        }
        
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else {
            return nil
        }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cachesLifeTime,
              let image = UIImage(contentsOfFile: fileName)
        else {
            return nil
        }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
    }
    
    private func loadPhoto(atIndexPath indexPath: IndexPath, byUrl url: String) {
        PhotoService.session.request(url)
            .responseData(
                queue: DispatchQueue.global(),
                completionHandler: { [weak self] response in
                    guard let data = response.data,
                      let image = UIImage(data: data)
                    else {
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.images[url] = image
                    }
                    
                    self?.saveImageToCache(url: url, image: image)
                    
                    DispatchQueue.main.async {
                        self?.container.reloadRow(atIndexpath: indexPath)
                    }
                
                }
            )
    }
    
    func getPhoto(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        
        if let photo = images[url] {
            image = photo
            print("\(url) : ОПЕРАТИВНАЯ ПАМЯТЬ")
        } else if let photo = getImageFromCache(url: url) {
            print("\(url) : ФИЗИЧЕСКАЯ ПАМЯТЬ")
            image = photo
        } else {
            print("\(url) : ДАННЫЕ ИЗ СЕТИ")
            loadPhoto(atIndexPath: indexPath, byUrl: url)
        }
        
        return image
    }
    
}

private protocol DataReloadable {
    
    func reloadRow(atIndexpath indexPath: IndexPath)
    
}

extension PhotoService {
    
    private class Table: DataReloadable {
        
        let tableView: UITableView
        
        init(tableView: UITableView) {
            self.tableView = tableView
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        
    }
    
    private class Collection: DataReloadable {
        
        let collectionView: UICollectionView
        
        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collectionView.reloadItems(at: [indexPath])
        }
        
    }
}
