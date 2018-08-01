//
//  CustomImageView.swift
//  InstragramRemind
//
//  Created by Jae Ki Lee on 8/1/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUserToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUserToLoadImage = urlString
        
        self.image = nil
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Faied to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUserToLoadImage{
                return
            }
            
            guard let imageData = data else {return}
            
            let photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
        }.resume()
    }
    
}
