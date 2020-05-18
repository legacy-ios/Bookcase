//
//  UIImageView+Extesions.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

extension UIImageView {
    
    struct ImageCache {
        static let cache = NSCache<AnyObject, AnyObject>()
    }

    func loadImage(urlString: String) {
        
        if self.image != nil {
            self.image = nil
        }
        
        if let imageFromCache = ImageCache.cache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        ImageCache.cache.setObject(image, forKey: url.absoluteString as AnyObject)
                    }
                }
            }
        }
    }
}
