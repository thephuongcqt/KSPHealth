//
//  Extension.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import Realm

class Utils{
    
}

extension String{
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
