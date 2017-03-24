//
//  DynamicsVC.swift
//  AnimationsDemo
//
//  Created by Artemiy Sobolev on 15/03/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

class DynamicsVC: UIViewController {
    
    @IBOutlet weak var animationsView: UIView!
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.animationsView)
    }()

    func addBehaviours(for view: UIView) {
        let gravity = UIGravityBehavior(items: [view])
        animator.addBehavior(gravity)
        
        let collisions = UICollisionBehavior(items: [view])
        collisions.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisions)
    }
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        
        let position = sender.location(in: animationsView)
        
        let box = UIView(frame: CGRect(x: position.x - 25, y: position.y - 15, width: 50, height: 30))
        animationsView.addSubview(box)
        
        box.backgroundColor = .red
        
        addBehaviours(for: box)
        
    }
    
}
