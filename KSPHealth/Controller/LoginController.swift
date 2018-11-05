//
//  LoginController.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/5/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: UIViewController{
    var viewModel: ViewModelType!
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(with: viewModel)
    }
}

extension LoginController: ControllerType{

    typealias ViewModelType = LoginControllerViewModel
    
    func configure(with viewModel: LoginControllerViewModel) {
        tfEmail.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.email)
            .disposed(by: disposeBag)
        
        tfPassword.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.password)
            .disposed(by: disposeBag)
        btnLogin.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)
        
        viewModel.output.errorObservable
            .subscribe(onNext: { [unowned self] (error) in
                self.presentError(error)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.loginResultObservable
            .subscribe(onNext: { [unowned self] (user) in
                self.presentMessage("User successfully signed in")
            })
            .disposed(by: disposeBag)
        
        // enable/ disable button
        let emailValidation = tfEmail.rx.text.map({!($0?.isEmpty ?? false)}).share()
        let passwordValidation = tfPassword.rx.text.map({!($0?.isEmpty ?? false)}).share()        
    }
    
    static func create(with viewModel: LoginControllerViewModel) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        controller.viewModel = viewModel
        return controller
    }
}
