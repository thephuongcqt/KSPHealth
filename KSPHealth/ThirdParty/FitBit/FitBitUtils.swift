//
//  FitBitUtils.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import OAuthSwift

let fitbit_clientID="22D4HH"
let fitbit_consumer_secret="94727a9fff42aaf57e635051eef69102"
let fitbit_redirect_uri="ksphealth://oauth-callback/demo"

class FitBitUtils: NSObject {
    static let shared = FitBitUtils()
    
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
    
    func fetchData(completion: @escaping (_ result: [String: Any],_ success: Bool) -> ()){
        let token = UserDefaults.standard.value(forKey: "AuthenToken")
        if let _ = token{
            self.getProfielFitbit2()
        } else{
            doOAuthFitbit2 { (success) in
                if success{
                    self.getProfielFitbit2()
                } else{
                    print("Authentication fail")
                }                
            }
        }
    }
    
    func doOAuthFitbit2(completion: @escaping (_ success:Bool) -> Void) {
        oauthFitbit.accessTokenBasicAuthentification = true
        let state: String = generateState(withLength: 20)
        oauthFitbit.authorize(withCallbackURL: URL(string: fitbit_redirect_uri), scope: "profile activity heartrate weight nutrition location", state: state, success: { (credential, response, parameters) in
            self.parameter = parameters as! [String : String]
            self.accessToken = parameters["access_token"] as? String
            print(self.accessToken as Any)
            print(parameters)
            UserDefaults.standard.setValue(self.accessToken, forKey: "AuthenToken")
            completion(true)
        }) { (error) in
            print(error.localizedDescription)
            completion(false)
        }
    }
        
}
