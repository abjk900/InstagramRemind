//
//  FirebaseUtils.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 8/2/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String : Any] else {return}
            
            let user = User(uid: uid, dictionary: userDictionary)
            
            completion(user)
            
        }) { (err) in
            print("Faile to fetch user for posts:", err)
        }
    }
    
}
