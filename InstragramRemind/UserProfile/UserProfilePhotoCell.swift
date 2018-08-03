//
//  UserProfilePhotoCell.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 7/26/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit
import Firebase

class UserProfilePhotoCell : UICollectionViewCell {
    
    var post: Post? {
        didSet{
            guard let postUrl = post?.imageUrl else {return}
            
            postImageView.loadImage(urlString: postUrl)
        }
    }
    
    var postImageView: CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
