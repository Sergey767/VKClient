//
//  MyGroupsViewController.swift
//  Vkontakte
//
//  Created by Серёжа on 29/06/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class MyGroupsViewController: UITableViewController {
    
    private let parseData = ParseData()
    private let realm = try! Realm()
    private let groups = try? Realm().objects(Group.self)
    private var notificationToken: NotificationToken?
    
    private let baseUrl = "https://api.vk.com"
    private let versionAPI = "5.92"
    private let path = "/method/groups.get"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData.loadGroups(token: Singleton.instance.token) { [weak self] groups in
            try? RealmProvider.save(items: groups)
        }
        
        notificationToken = groups?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                fatalError("\(error)")
            }
        }
        
        tableView.tableFooterView = UIView()
    }
    
    func asyncLoadData() {
        
        let queue = OperationQueue()

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "extended": 1,
            "v": versionAPI
        ]

        let request = ParseData.session.request(baseUrl + path, method: .get, parameters: params)

        let loadOperation = GetDataOperation(request: request)
        queue.addOperation(loadOperation)

        let parseData = ParseData()
        parseData.addDependency(loadOperation)
        queue.addOperation(parseData)
        
        let realmProvider = RealmProvider()
        realmProvider.addDependency(parseData)
        queue.addOperation(realmProvider)
    }
        
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
        
        let group = (groups?[indexPath.row])!
        cell.configure(with: group)
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! MyGroupsCell
        
         let animation = CASpringAnimation(keyPath: "transform.scale")
                      animation.fromValue = 0
                      animation.toValue = 0.5
                      animation.duration = 0.3
                      animation.damping = 0.5
                      animation.initialVelocity = 0
                      animation.stiffness = 200
                      animation.mass = 2
                      animation.fillMode = CAMediaTimingFillMode.backwards
                      animation.isRemovedOnCompletion = false
                    cell.myGroupsImageView.layer.add(animation, forKey: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRow = groups?[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
            try! self.realm.write {
                self.realm.delete(editingRow!)
            }
        }
        return [deleteAction]
    }
}
