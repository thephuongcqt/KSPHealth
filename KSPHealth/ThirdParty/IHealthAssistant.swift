//
//  iHealthRepository.swift
//  KSPHealth
//
//  Created by Nguyen The Phuong on 11/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

protocol IHealthAssistant {
    func authorizeRepository(completion: @escaping (_ success: Bool, _ error: Error?) -> ())    
}
