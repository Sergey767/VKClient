//
//  ParseDataOperation.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 01.10.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ParseData: Operation {

    private var outputData = [Group]()
    
    private let baseUrl = "https://api.vk.com"
    private let versionAPI = "5.92"
    
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return session
    }()

        func loadGroups(token: String, completion: @escaping ([Group]) -> Void) {
            
            let path = "/method/groups.get"

            let params: Parameters = [
                "access_token": Singleton.instance.token,
                "extended": 1,
                "v": versionAPI
            ]

            ParseData.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let groupJSONs = json["response"]["items"].arrayValue
                    let groups = groupJSONs.map { Group($0, token: token) }
                    self.outputData = groups
                    completion(groups)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
        }

    func getOutPutDate() -> [Group] {
        return outputData
    }
}


