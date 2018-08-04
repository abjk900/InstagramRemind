//
//  Post.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 8/1/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import Foundation

struct Post {
    
    var id: String?
    
    let caption: String
    let imageUrl: String
    let creationDate: Date
    
    let user: User?
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
    
}
