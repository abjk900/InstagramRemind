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
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotificationName, object: nil)

        collectionView?.backgroundColor = .white
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        fetchPosts()
        
    }
    
    @objc func handleUpdateFeed() {
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        print("Handling refresh")
        fetchPosts()
    }

    var posts = [Post]()
    
    fileprivate func fetchPosts(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.fetchUserWithUID(uid: uid) {(user) in
            self.fetchPostsWithUser(user: user)
        }
    }
    
    fileprivate func fetchPostsWithUser(user: User) {
        Database.database().reference().child("posts").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String : Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                var post = Post(user: user, dictionary: dictionary)
                //for each post's option
                post.id = key
                self.posts.append(post)
                
                //posts showing depend on time
                self.posts.sort(by: { (p1, p2) -> Bool in
                    return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                })
                
                self.collectionView?.reloadData()
            })
            
        }) { (err) in
            print("Failed to fetch posts:", err)
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
        
        return cell
    }
    
}
