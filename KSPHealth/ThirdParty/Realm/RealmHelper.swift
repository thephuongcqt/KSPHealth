//
//  RealmDB.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/31/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper: IDBHealper{
    static let shared = RealmHelper()

    lazy var realm = try? Realm()

    func save<T>(item: T, completion: @escaping (Bool, Error?) -> ()) {
        if let realm = realm, let item = item as? Object{
            do {
                try realm.write {
                    realm.add(item)
                }
                completion(true, nil)
            } catch let error{
                completion (false, error)
            }
        }
        completion(false, BaseError.initRealmFailure)
    }

    func save<T>(items: [T], completion: @escaping (Bool, Error?) -> ()) {
        if let realm = realm, let items = items as? [Object]{
            do {
                try realm.write {
                    realm.add(items)
                }
                completion(true, nil)
                return
            } catch let error{
                completion (false, error)
                return
            }
        }
        completion(false, BaseError.initRealmFailure)
    }

    func getAll<T>(objectType: T.Type, completion: @escaping ([T], Error?) -> ()) {
        if let realm = realm, let objType = objectType as? Object.Type{
            let list = realm.objects(objType).toArray(ofType: objectType)
            completion(list, nil)
            return
        }
        completion([], BaseError.initRealmFailure)
    }
    
    func delete<T>(item: T, completion: @escaping (Bool, Error?) -> ()) {
        if let realm = realm, let item = item as? Object{
            do {
                try realm.write {
                    realm.delete(item)
                }
                completion(true, nil)
            } catch let error{
                completion (false, error)
            }
        }
        completion(false, BaseError.initRealmFailure)
    }    
}
