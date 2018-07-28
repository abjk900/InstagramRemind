//
//  User.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 7/26/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let username: String
    let profileImagUrl: String
    
    init(uid: String, dictionary: [String : Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImagUrl = dictionary["profileImageUrl"] as? String ?? ""
        
    }
}
