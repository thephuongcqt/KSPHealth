//
//  FitBitUtils+GetData.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

extension FitbitAssistant{
    func fetchData(completion: @escaping (_ result: [String: Any],_ success: Bool) -> ()){
        let token = UserDefaults.standard.value(forKey: "AuthenToken")
        if let _ = token{
            self.getProfielFitbit()
            self.getActivityData()
            self.getStepCount()
        } else{
            authorizeRepository(completion: { (success, error) in
                if success{
                    self.getProfielFitbit()
                    self.getActivityData()
                    self.getStepCount()
                } else{
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
    func getProfielFitbit() {
        let token = UserDefaults.standard.value(forKey: "AuthenToken")
        let header=["Authorization":"Bearer "+(token as! String)]
        oauthFitbit.client.request(getProfileUrl, method: .GET, parameters: [:], headers: header, body: nil, checkTokenExpiration: true, success: { (response) in
            let jsonDict = try? JSONSerialization.jsonObject(with: response.data, options: [])
            print(jsonDict ?? "nil")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getActivityData(){
        let token = UserDefaults.standard.value(forKey: "AuthenToken")
        let header = ["Authorization":"Bearer " + (token as! String)]
        let activityUrl = "https://api.fitbit.com/1/user/-/activities/list.json?offset=2&limit=5&sort=desc&beforeDate=2018-11-01"
        oauthFitbit.client.request(activityUrl, method: .GET, parameters: [:], headers: header, body: nil, checkTokenExpiration: true, success: { (response) in
            let jsonDict = try? JSONSerialization.jsonObject(with: response.data, options: [])
            print(jsonDict ?? "nil")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getStepCount(){
        let token = UserDefaults.standard.value(forKey: "AuthenToken")
        let header=["Authorization":"Bearer "+(token as! String)]
        let stepUrl = "https://api.fitbit.com/1/user/-/activities/steps/date/2018-11-01/1m.json"
        oauthFitbit.client.request(stepUrl, method: .GET, parameters: [:], headers: header, body: nil, checkTokenExpiration: true, success: { (response) in
            let jsonDict = try? JSONSerialization.jsonObject(with: response.data, options: [])
            print(jsonDict ?? "nil")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

