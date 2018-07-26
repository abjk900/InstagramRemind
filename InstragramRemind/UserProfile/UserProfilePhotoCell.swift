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
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
