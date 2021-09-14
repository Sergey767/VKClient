//
//  GetDataOperation.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 01.10.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {

    private var request: DataRequest

    var data: Data?
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
    func getLoadedData() -> Data? {
        return data
    }
}
