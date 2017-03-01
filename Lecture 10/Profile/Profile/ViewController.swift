//
//  ViewController.swift
//  Profile
//
//  Created by Artemiy Sobolev on 01/03/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

extension URL {
    static var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}


class ViewController: UIViewController {

    let profileURL = URL.documentsURL.appendingPathComponent("profile")
    
    var updateOperation: Operation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var profile: Profile?
        
        let readOperation = ReadOperation(url: profileURL) { (p: Profile) in
            profile = p
        }
        
        updateOperation = BlockOperation { [weak self] in
            // shows alert, vc
            
            if let profile = profile {
                print("\(profile)")
            } else {
                guard let strongSelf = self else { return }
                
                let alertController = UIAlertController.enterName(handler: strongSelf.saveProfile)
                strongSelf.present(alertController, animated: true)
            }
            
        }
        
        updateOperation.addDependency(readOperation)
        OperationQueue().addOperation(readOperation)

    }
    
    func saveProfile(with name: String) {
        let profile = Profile(identifier: UUID().uuidString, email: name)
        let writeOperation = WriteOperation(url: profileURL, object: profile)
        
        OperationQueue().addOperation(writeOperation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        OperationQueue.main.addOperation(updateOperation)
    }

}

extension UIAlertController {
    
    static func enterName(handler: @escaping (String) -> Void) -> UIAlertController {
        
        let result = UIAlertController(title: "Enter name", message: nil, preferredStyle: .alert)
        
        var textField: UITextField?
        result.addTextField { tf in
            textField = tf
            tf.placeholder = "Your name"
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let name = textField?.text else {
                return
            }
            handler(name)
            
        }
        
        result.addAction(okAction)
        
        return result
        
    }
    
    
}

