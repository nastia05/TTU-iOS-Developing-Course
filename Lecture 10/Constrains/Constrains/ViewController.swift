//
//  ViewController.swift
//  Constrains
//
//  Created by Artemiy Sobolev on 01/03/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var strokeColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var fillColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        fillColor.setFill()
        strokeColor.setStroke()
        let bezierPath = UIBezierPath(ovalIn: bounds.smaller(lineWidth: 1))
        bezierPath.stroke()
        bezierPath.fill()
    }
    
}

extension CGRect {
    func smaller(lineWidth: CGFloat) -> CGRect {
        return CGRect(x: origin.x + lineWidth * 0.5, y: origin.y + lineWidth * 0.5, width: width - lineWidth, height: height - lineWidth)
    }
}

class ViewController: UIViewController {

}

