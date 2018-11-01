//
//  RPost.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import RealmSwift

class RPost: Object{
    @objc dynamic var userID = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    
    convenience init(post: Post) {
        self.init()
        userID = post.userID
        id = post.id
        title = post.title
        body = post.body
    }
}
