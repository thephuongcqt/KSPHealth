//
//  LoginControllerViewModel.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/5/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import RxSwift

class LoginControllerViewModel: ViewModelProtocol {
    typealias Input = LoginInput
    typealias Output = LoginOutput
    
    let input: Input
    let output: Output
    
    private let emailSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let loginResultSubject = PublishSubject<User>()
    private let errorsSubject = PublishSubject<Error>()
    
    private let disposeBag = DisposeBag()
    
    private var credentialsObservable: Observable<Credentials>{
        return Observable.combineLatest(emailSubject.asObservable(), passwordSubject.asObservable()) { (email, password) in
            return Credentials(email: email, password: password)
        }
    }

    init(_ loginService: LoginServiceProtocol){
        input = Input(email: emailSubject.asObserver(), password: passwordSubject.asObserver(), signInDidTap: signInDidTapSubject.asObserver())
        output = Output(loginResultObservable: loginResultSubject.asObserver(), errorObservable: errorsSubject.asObserver())
        
        signInDidTapSubject
            .withLatestFrom(credentialsObservable)
            .flatMapLatest { credentials in
                return loginService.signIn(with: credentials).materialize()
            }
            .subscribe(onNext: { [weak self] event in
                switch event {
                case .next(let user):
                    self?.loginResultSubject.onNext(user)
                case .error(let error):
                    self?.errorsSubject.onNext(error)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)        
    }
    
}

struct LoginInput {
    let email: AnyObserver<String>
    let password: AnyObserver<String>
    let signInDidTap: AnyObserver<Void>
}

struct LoginOutput{
    let loginResultObservable: Observable<User>
    let errorObservable: Observable<Error>
}
