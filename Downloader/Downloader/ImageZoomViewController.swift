//
//  ImageZoomViewController.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController {
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewmain: UIImageView!
    var imageURL:String? = nil
    
    @IBAction func closeButon(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator.startAnimating()
        let _ = DownloadManager.sharedDownloadManager().getImage(withAddressURL: URL(string:imageURL!)!) { (image) in
            DispatchQueue.main.async {
                self.imageViewmain.image = image
                self.actIndicator.stopAnimating()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
