//
//  HomeController.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 7/28/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
        fetchUser()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)

    }
    
    var posts = [Post]()
    
    fileprivate func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("posts").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String : Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let post = Post(uid: uid, dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch posts:", err)
        }
    }
    
    var user: User?
    
    fileprivate func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String : Any] else {return}
            
            self.user = User(uid: uid, dictionary: userDictionary)
            
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
    //Cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        
        cell.post = posts[indexPath.item]
        cell.user = user
        
        return cell
    }
    
}
