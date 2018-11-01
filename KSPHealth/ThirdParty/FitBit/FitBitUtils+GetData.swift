//
//  FitBitUtils+GetData.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

extension FitBitUtils{
    func getProfielFitbit2() {
        let token = UserDefaults.standard.value(forKey: "AuthenToken")
        let header=["Authorization":"Bearer "+(token as! String)]                
        
        oauthFitbit.client.request(getProfileUrl, method: .GET, parameters: [:], headers: header, body: nil, checkTokenExpiration: true, success: { (response) in
            if let jsonString = response.dataString(){
                let dictionary = jsonString.convertToDictionary()
                print(jsonString)
            } else{
                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

