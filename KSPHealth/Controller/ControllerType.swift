//
//  ControllerType.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/5/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import UIKit

protocol ControllerType: class {
    associatedtype ViewModelType: ViewModelProtocol
    
    func configure(with viewModel: ViewModelType)
    
    static func create(with viewModel: ViewModelType) -> UIViewController
}
