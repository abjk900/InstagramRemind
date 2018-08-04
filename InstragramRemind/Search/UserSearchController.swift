//
//  UserSearchController.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 8/2/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    let cellId = "CellId"
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        collectionView?.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .onDrag
        
        fetchUsers()
        
        searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            fileterdUser = users
        }else {
            fileterdUser = self.users.filter({ (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            })
            //collectionView.reloaData() 를 안해주면 새로 갱신된 filetedUser 가 cell 에 나타나지 않는다.
            self.collectionView?.reloadData()
            
        }
    }
    
    var users = [User]()
    var fileterdUser = [User]()
    
    fileprivate func fetchUsers() {
        print("Fetching users...")
        
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String : Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                
                if key == Auth.auth().currentUser?.uid {
                    print("Found myself, omit from list")
                    return
                }
                
                guard let userDictionary = value as? [String : Any] else {return}
                
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
            })
            
            self.users.sort(by: { (u1, u2) -> Bool in
                return u1.username.compare(u2.username) == .orderedAscending
            })
            
            self.fileterdUser = self.users
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch users for serach:", err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileterdUser.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserSearchCell
        
        cell.user = fileterdUser[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
    
}
