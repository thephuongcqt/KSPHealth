//
//  FitBitUtils.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import OAuthSwift

let fitbit_clientID = "22D4HH"
let fitbit_consumer_secret = "94727a9fff42aaf57e635051eef69102"
let fitbit_redirect_uri = "ksphealth://oauth-callback/demo"

class FitbitAssistant: IHealthAssistant{
    static let shared = FitbitAssistant()
    
    let getProfileUrl = "https://api.fitbit.com/1/user/-/profile.json"
    
    let oauthFitbit = OAuth2Swift(
        consumerKey: fitbit_clientID,
        consumerSecret: fitbit_consumer_secret,
        authorizeUrl: "https://www.fitbit.com/oauth2/authorize",
        accessTokenUrl: "https://api.fitbit.com/oauth2/token",
        responseType: "token"
    )
    
    var parameter = [String: String]()
    var accessToken:String?
    
    typealias fitbitCompletion = (_ result: [String: Any],_ success: Bool) -> ()
    var completionHandler = fitbitCompletion.self    
    
    func authorizeRepository(completion: @escaping (Bool, Error?) -> ()) {
        oauthFitbit.accessTokenBasicAuthentification = true
        let state: String = generateState(withLength: 20)
        oauthFitbit.authorize(withCallbackURL: URL(string: fitbit_redirect_uri), scope: "profile activity heartrate weight nutrition location", state: state, success: { (credential, response, parameters) in
            self.parameter = parameters as! [String : String]
            self.accessToken = parameters["access_token"] as? String
            
            UserDefaults.standard.setValue(self.accessToken, forKey: "AuthenToken")
            completion(true, nil)
        }) { (error) in
            print(error.localizedDescription)
            completion(false, error)
        }
    }
}
