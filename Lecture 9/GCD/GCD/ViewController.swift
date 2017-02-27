//
//  ViewController.swift
//  GCD
//
//  Created by Artemiy Sobolev on 22/02/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

extension UIViewController {
    var errorHandler: (Error) -> Void {
        return { [weak self] error in
            let alert = UIAlertController(title: "Error", message: (error as NSError).description, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            
            self?.present(alert, animated: true)
            
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    @IBAction func downloadButtonPressed(_ sender: UIButton) {
    
        let monkeyPath = "https://upload.wikimedia.org/wikipedia/commons/4/4e/Macaca_nigra_self-portrait_large.jpg"
        guard let url = URL(string: monkeyPath) else {
            fatalError("wrong path")
        }
        
        activityView.startAnimating()
        sender.isEnabled = false
        
        UIImage.download(at: url, errorHandler: errorHandler) { [weak self, weak sender] image in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.imageView.image = image
            strongSelf.activityView.stopAnimating()
            sender?.isEnabled = true
        }
        
    }
}

