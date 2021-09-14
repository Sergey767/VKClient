//
//  SearchGroupTableViewController.swift
//  Vkontakte
//
//  Created by Серёжа on 29/06/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit

class SearchGroupTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let networkService = NetworkService()
    private var photoService: PhotoService?
    private var searchGroups = [SearchGroup]()
    private var timer: Timer?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService(container: tableView)
        
        setupSearchBar()
        
        tableView.tableFooterView = UIView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchGroupCell") as! SearchGroupCell
        
        let searchGroup = searchGroups[indexPath.row]
        
        let urlImage = searchGroup.photo
        let image = photoService?.getPhoto(atIndexPath: indexPath, byUrl: urlImage)
        
        cell.searchGroupImageView.image = image
        
        cell.searchGroupImageView.layer.cornerRadius = cell.searchGroupImageView.frame.size.width / 2
        cell.searchGroupImageView.clipsToBounds = true
        
        cell.configure(with: searchGroup)
        
        return cell
    }
}

    // MARK - UISearchBarDelegate
extension SearchGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
            self.networkService.loadSearchGroups(searchQuery: searchText) { [weak self] searchGroups in
                self?.searchGroups = searchGroups
                self?.tableView.reloadData()
            }
        })
    }
}
