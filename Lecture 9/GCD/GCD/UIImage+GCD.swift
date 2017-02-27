//
//  UIImage+GCD.swift
//  GCD
//
//  Created by Artemiy Sobolev on 22/02/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

private let downloadQueue = DispatchQueue(label: "loading", qos: .userInitiated)

extension UIImage {
    static func download(at url: URL, errorHandler eh: @escaping (Error) -> Void, successHandler sh: @escaping (UIImage) -> Void) {
        
        downloadQueue.async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    sh(image)
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    eh(error)
                }
            }
        }
        
        
        
    }
}

