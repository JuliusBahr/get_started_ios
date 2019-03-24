//
//  FlickrSearch.swift
//  FlickerSearch
//
//  Created by Julius Bahr on 22.03.19.
//  Copyright © 2019 Julius Bahr. All rights reserved.
//

import Foundation
import UIKit

struct FlickrSearchResult {
    let searchTerm : String
    let searchResult : [UIImage]
}

enum FlickrSearchError: Error {
    case wrongQuery
    case serverError
}

struct FlickrSearch {
    private static let apiKey = "41efa4c7e50ddefc4b62e3fb077eaf21"
    private static let apiSecret = "f86018435c5f99bf"
    
    private static let searchTemplate = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1"
    
    
    /// Search for a search term on flickr
    ///
    /// - Parameters:
    ///   - searchTerm: the term to search for
    ///   - success: called when the flickr backend returns images, may be called on a background thread
    ///   - error: called when the flickr search fails, may be called on a background thread
    func searchFlickr(for searchTerm: String, success: @escaping (FlickrSearchResult) -> Void, error: @escaping(Error) -> Void) {
        
        guard let searchUrl = FlickrSearch.url(for: searchTerm) else {
            error(FlickrSearchError.wrongQuery)
            return
        }
        
        let urlRequest = URLRequest(url: searchUrl)
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, innerError) in
            
            if let innerError = innerError {
                error(innerError)
                return
            }
            
            guard let data = data else {
                error(FlickrSearchError.serverError)
                return
            }
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data)
                dump(jsonDictionary)
            } catch let innerError {
                error(innerError)
            }
            
        }
        
        urlSession.resume()
    }
    
    private static func url(for searchTerm: String) -> URL? {
        guard let escapedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        return URL(string: String.init(format: searchTemplate, apiKey, escapedSearchTerm))
    }

}
