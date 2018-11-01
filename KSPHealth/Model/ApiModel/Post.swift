//
//  Post.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable{
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userID <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
    
    var userID: Int = 0
    var id: Int = 0
    var title: String = ""
    var body: String = ""
}
