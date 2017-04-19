//
//  ViewController.swift
//  BigFileDownload
//
//  Created by Artemiy Sobolev on 05/04/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import UIKit

class BackgroundDownloader: NSObject, URLSessionDownloadDelegate {
    
    var session: URLSession!
    let queue = OperationQueue()
    let url: URL
    init(url: URL) {
        self.url = url
        super.init()
        session = URLSession(configuration: .background(withIdentifier: "com.mipt.downloader"), delegate: self, delegateQueue: queue)
    
    }
    
    var successHandler: ((Data) -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func download(successHandler: @escaping (Data) -> Void) {
        self.successHandler = successHandler
        let task = session.downloadTask(with: url)
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
            return
        }
        errorHandler?(error)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        do {
            let data = try Data(contentsOf: location)
            successHandler?(data)
        } catch let error {
            errorHandler?(error)
        }
        
    }
    
}

class ViewController: UIViewController {

    let downloader = BackgroundDownloader(url: URL(string: "https://apple.com")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloader.download { data in
            
        }
        
        
    }


}

