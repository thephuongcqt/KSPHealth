//
//  BaseServices.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 10/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol ResponseDelegete {
    func onSuccess<T>(result: T)
    func onFailure(error: Error)
}

typealias completionHandler<T> = (T?) -> ()

class BaseService{
    
    var baseUrl: String{
        get{
            if let url = ProcessInfo().environment["BASE_URL"]{                
                return url
            }
            return ""
        }
    }
    
    func getRequest<T:Mappable>(with url: URLConvertible, parameters: [String: Any], header: HTTPHeaders?, completion: @escaping (NetworkResult<T>) -> ()){
        Alamofire.request(url, method: .get, parameters: parameters, headers: header)
            .validate(statusCode: 200...300)
            .responseObject { (resonse: DataResponse<T>) in
                switch resonse.result{
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):                    
                    completion(.failure(error: error))
                }
        }
    }
    
    func postRequest<T:Mappable>(with url: URL, parameters: [String: Any], header: HTTPHeaders?, completion: @escaping (NetworkResult<T>) -> ()){
        Alamofire.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...300)
            .responseObject { (resonse: DataResponse<T>) in
                switch resonse.result{
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error: error))
                }
        }
    }
}
