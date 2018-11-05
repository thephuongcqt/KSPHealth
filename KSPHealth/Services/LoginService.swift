//
//  LoginService.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/5/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginServiceProtocol {
    func signIn(with credentials: Credentials) -> Observable<User>
}

class LoginService: LoginServiceProtocol {
    // Demo Service for MVVM
    func signIn(with credentials: Credentials) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            observer.onNext(User())
            return Disposables.create()
        })
    }
}
