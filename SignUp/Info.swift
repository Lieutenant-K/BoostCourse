//
//  Singleton.swift
//  SignUp
//
//  Created by 김윤수 on 2021/12/29.
//

import Foundation

class Info {
    
    static let info = Info()
    
    var id: String? = nil
    var pw: String? = nil
    
    private init(){}
    
}
