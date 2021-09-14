//
//  NewsViewController.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 04.09.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    private let networkService = NetworkService()
    var postNews: VKNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadNews(token: Singleton.instance.token, completion: { [weak self] news, error in
            guard error == nil else {
                print("Some error in loading data")
                return
            }
            self?.postNews = news
            self?.tableView.reloadData()
        })
        
        setupRefreshControl()
        
        tableView.prefetchDataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.tintColor = .gray
        refreshControl?.addTarget(
            self,
            action: #selector(refreshNews),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
    }

    @objc func refreshNews() {
        refreshControl?.beginRefreshing()
        
        networkService.loadNews(token: Singleton.instance.token, completion: { [weak self] news, error in
            guard error == nil else {
                print("Some error in loading data")
                return
            }
            self?.postNews = news
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        })
    }
    
    @objc func expandCollapse(sender: UIButton) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postNews?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostNewsCell", for: indexPath) as? PostNewsCell
            
            guard let postCell = cell, let postNews = postNews else {
                return UITableViewCell()
            }
            
            let sourceID = postNews.items[indexPath.row].sourceId
            let ownerGroupNews = postNews.groups.filter { $0.groupId == -sourceID }.first
            let ownerProfilesNews = postNews.profiles.filter { $0.profilesId == sourceID }.first
            
            let ownerName = ownerProfilesNews == nil ? ownerGroupNews?.nameGroup :
                ownerProfilesNews!.firstName + " " + ownerProfilesNews!.lastName
            let ownerAvatarImage = ownerProfilesNews == nil ? ownerGroupNews?.photo : ownerProfilesNews?.photo

            postCell.imageAvatarNews.kf.setImage(with: URL(string: ownerAvatarImage ?? ""))
            postCell.imageAvatarNews.layer.cornerRadius = postCell.imageAvatarNews.frame.size.width / 2
            postCell.imageAvatarNews.clipsToBounds = true

            postCell.userNameNews.text = ownerName
            
            postCell.btnExpandCollepse.addTarget(self, action: #selector(NewsViewController.expandCollapse(sender:)), for: .touchUpInside)
            
            postCell.configure(with: postNews.items[indexPath.row], ownerGroupNews: ownerGroupNews, ownerProfilesNews: ownerProfilesNews)
                return postCell
            
        } else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNewsCell", for: indexPath) as? PhotoNewsCell
            
            guard let photoCell = cell, let postNews = postNews else {
                return UITableViewCell() }
            
            let sourceID = postNews.items[indexPath.row].sourceId
            let ownerGroupNews = postNews.groups.filter { $0.groupId == -sourceID }.first
            let ownerProfilesNews = postNews.profiles.filter { $0.profilesId == sourceID }.first
            
            let ownerName = ownerProfilesNews == nil ? ownerGroupNews?.nameGroup : ownerProfilesNews!.firstName + " " + ownerProfilesNews!.lastName
            
            let ownerAvatarImage = ownerProfilesNews == nil ? ownerGroupNews?.photo : ownerProfilesNews?.photo
            
            var ratio: CGFloat = 1.0000
            
            let photoWidth = postNews.items[indexPath.row].photoWidth
            let photoHeight = postNews.items[indexPath.row].photoHeight
            
            if photoHeight != 0 {
                ratio = CGFloat(photoWidth) / CGFloat(photoHeight)
            }
            
            let calcPhotoHeight = tableView.frame.width / ratio
            
            photoCell.imageAvatarNews.kf.setImage(with: URL(string: ownerAvatarImage ?? ""))
            photoCell.imageAvatarNews.layer.cornerRadius = photoCell.imageAvatarNews.frame.size.width / 2
            photoCell.imageAvatarNews.clipsToBounds = true
            
            photoCell.userNameNews.text = ownerName
            
            photoCell.configure(
                with: postNews.items[indexPath.row],
                ownerGroupNews: ownerGroupNews,
                ownerProfilesNews: ownerProfilesNews,
                photoHeight: calcPhotoHeight
            )
            return photoCell
        }
    }
}

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isLoadingCell(for:)) else {
            return
        }
        
            networkService.loadPartNews(
                startFrom: Singleton.instance.nextFrom,
                token: Singleton.instance.token,
                completion: { [weak self] news, error, dateFrom in
                    guard let self = self else {
                        return
                    }
                    
                    self.postNews?.items = (self.postNews?.items ?? []) + (news?.items ?? [])
                    self.postNews?.groups = (self.postNews?.groups ?? []) + (news?.groups ?? [])
                    self.postNews?.profiles = (self.postNews?.profiles ?? []) + (news?.profiles ?? [])
                    
                    self.tableView.reloadData()
                }
            )
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let newsCount = postNews?.items.count ?? 0
        return indexPath.row == newsCount - 3
    }
}
