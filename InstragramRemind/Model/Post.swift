//
//  Post.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 8/1/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import Foundation

struct Post {
    let uid: String
    let caption: String
    let imageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
    
}
