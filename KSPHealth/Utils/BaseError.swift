//
//  File.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/31/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

enum BaseError: Error{
    case unknowError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
    case initRealmFailure
    case castDataFailure
}
