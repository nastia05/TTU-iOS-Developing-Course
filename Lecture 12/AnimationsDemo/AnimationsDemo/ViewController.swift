//
//  ViewController.swift
//  AnimationsDemo
//
//  Created by Artemiy Sobolev on 15/03/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueBox: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.blueBox.backgroundColor = .red
            strongSelf.bottomConstraint.constant = 250
            strongSelf.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.blueBox.backgroundColor = .red
            strongSelf.bottomConstraint.constant = 100
            strongSelf.view.layoutIfNeeded()
            }, completion: nil)
    }
    

}

