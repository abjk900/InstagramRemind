//
//  MainTabBarController.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 7/25/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITabBarControllerDelegate
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [userProfileNavController]
        
    }
}
