//
//  NotificationViewController.swift
//  ImageDownloadProgress
//
//  Created by nobroker on 05/04/18.
//  Copyright © 2018 VishalMadheshia. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        if let progress = notification.request.content.userInfo["progress"] as? Float {
            updateProgress(progress: progress)
        }
    }
    
    func updateProgress(progress: Float) {
        progressView.progress = progress
    }

}
