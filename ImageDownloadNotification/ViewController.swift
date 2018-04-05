//
//  ViewController.swift
//  ImageDownloadNotification
//
//  Created by nobroker on 05/04/18.
//  Copyright © 2018 VishalMadheshia. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scheduleLocal(progress: Float) {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Downloading image"
        content.body = "Downloading image"
        content.categoryIdentifier = "myNotificationCategory"
        content.userInfo = ["progress": progress]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.001, repeats: false)
        
        let request = UNNotificationRequest(identifier: "928734982374", content: content, trigger: trigger)
        center.add(request)
    }

    @IBAction func downloadImageButtonTapped(_ sender: Any) {
        // A 20MB image from NASA
        let url = URL(string: "http://eoimages.gsfc.nasa.gov/images/imagerecords/78000/78314/VIIRS_3Feb2012_lrg.jpg")!
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.vishal.demo.background")
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        // Don't specify a completion handler here or the delegate won't be called
        let task = session.downloadTask(with: url)
        task.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Downloaded \(totalBytesWritten) / \(totalBytesExpectedToWrite) bytes ")
        
        scheduleLocal(progress: Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
            DispatchQueue.main.async() {
                self.imageView.contentMode = .scaleAspectFit
                self.imageView.clipsToBounds = true
                self.imageView.image = image
            }
        } else {
            fatalError("Cannot load the image")
        }
    }
}

