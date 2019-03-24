//
//  FlickrSearch.swift
//  FlickerSearch
//
//  Created by Julius Bahr on 22.03.19.
//  Copyright © 2019 Julius Bahr. All rights reserved.
//

import Foundation
import UIKit

struct FlickrSearchResults {
    let searchTerm : String
    let searchResults : [UIImage]
}

enum FlickrSearchError: Error {
    case wrongQuery
    case serverError
}

struct FlickrSearch {
    private static let apiKey = "41efa4c7e50ddefc4b62e3fb077eaf21"
    private static let apiSecret = "f86018435c5f99bf"
    
    private static let searchTemplate = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1"
    
    func searchFlickr(for searchTerm: String, success: @escaping (Array<FlickrSearchResults>) -> Void, error: @escaping(Error) -> Void) {
        
        guard let searchRequest = FlickrSearch.url(for: searchTerm) else {
            error(FlickrSearchError.wrongQuery)
            return
        }
        
    }
    
    private static func url(for searchTerm: String) -> URL? {
        guard let escapedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        return URL(string: String.init(format: searchTemplate, apiKey, escapedSearchTerm))
    }

}
