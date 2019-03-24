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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func startSearch(_ sender: Any) {
        if let searchTerm = textField?.text {
            FlickrSearch().searchFlickr(for: searchTerm, success: { (result) in
                
            }) { (error) in
                
            }
        }
    }
    
    
}

