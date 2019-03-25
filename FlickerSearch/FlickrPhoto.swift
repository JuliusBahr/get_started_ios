//
//  FlickrPhotoMetadata.swift
//  FlickerSearch
//
//  Created by Julius Bahr on 24.03.19.
//  Copyright © 2019 Julius Bahr. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhoto {
    private let photoId: String
    private let serverFarm: Int
    private let server: String
    private let secret: String
    
    
    init?(from json: [String: AnyObject]) {
        guard
            let photoId = json["id"] as? String,
            let serverFarm = json["farm"] as? Int ,
            let server = json["server"] as? String ,
            let secret = json["secret"] as? String
            else {
                return nil
        }
        
        self.photoId = photoId
        self.serverFarm = serverFarm
        self.server = server
        self.secret = secret
    }
    
    
    /// loads the image for the Flickr metadata
    ///
    /// - Precondition: Please call on a background thread
    /// - Returns: the image if it can be loaded from the backend, nil otherwise
    func getImage() -> UIImage? {
        guard let imageUrl = imageUrl() else {
            return nil
        }
        
        // synchronous backend call
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return nil
        }
        
        if let image = UIImage(data: imageData) {
            return image
        } else {
            return nil
        }
    }
    
    private func imageUrl(_ size: String = "m") -> URL? {
        if let url =  URL(string: "https://farm\(serverFarm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg") {
            return url
        }
        return nil
    }
}
