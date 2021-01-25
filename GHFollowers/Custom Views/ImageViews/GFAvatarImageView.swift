//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/18/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache             = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image                = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /* This is the old way to download an image...we decided to refactor it to use the result
     * type and sent back.
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = self.cache.object(forKey: cacheKey ) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return } // wow you can just do this for an image...
            self.cache.setObject(image, forKey: cacheKey)
            // This download happens on a background thread, but now we have to update the main thread
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
    */
}
