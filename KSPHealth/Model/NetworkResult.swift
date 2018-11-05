//
//  NetworkResult.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

enum NetworkResult<T>{
    case success(T)
    case failure(error: Error)
}
