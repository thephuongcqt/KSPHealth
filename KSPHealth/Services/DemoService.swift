//
//  DemoService.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import Alamofire

class DemoService: BaseService {
    
    static let share = DemoService()
    
//    typealias postListResponse = NetworkResult<Post>
    
    func getPostList(with params: [String: Any], completion: @escaping completionHandler<[Post]>){
        print(baseUrl)
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
            Alamofire.request(url, method: .get, parameters: [:])
                .responseArray { (response: DataResponse<[Post]>) in
                    completion(response.value)
            }
        }
    }
}
