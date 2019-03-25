//
//  ViewController.swift
//  FlickerSearch
//
//  Created by Julius Bahr on 22.03.19.
//  Copyright © 2019 Julius Bahr. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet private weak var textField: UITextField?
    @IBOutlet private weak var textView: UITextView?
    @IBOutlet private weak var imageView: UIImageView?

    @IBAction func startSearch(_ sender: Any) {
        if let searchTerm = textField?.text {
            FlickrSearch().searchFlickr(for: searchTerm, success: { (result) in
                DispatchQueue.main.async {
                    self.imageView?.image = result.searchResult
                    self.textView?.text = nil
                }
            }) { (error) in
                DispatchQueue.main.async {
                    self.imageView?.image = nil
                    
                    switch error {
                    case .wrongQuery:
                        self.textView?.text = "Sorry, could not handle search text."
                    case .serverError:
                        self.textView?.text = "Sorry, the Flickr server did not respond."
                    case .apiMismatch:
                        self.textView?.text = "Sorry, this app is too old. We do not understand this version of the Flikr API. Please update this app."
                    }
                }
            }
        }
    }
    
    
}

