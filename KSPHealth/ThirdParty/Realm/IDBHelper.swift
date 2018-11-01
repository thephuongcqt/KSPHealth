//
//  IDBHelper.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/31/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol IDBHealper {
    func save<T>(item: T, completion: @escaping (Bool, Error?) -> ())    
    func save<T>(items: [T], completion: @escaping (Bool, Error?) -> ())
    func getAll<T>(objectType: T.Type, completion: @escaping ([T], Error?) -> ())
    func delete<T>(item: T, completion: @escaping (Bool, Error?) -> ())
}
