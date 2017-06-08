//
//  ListTableViewCell.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var imageToShow: UIImageView!
    @IBOutlet var indicator:UIActivityIndicatorView!
    private var request:ImageFetchRequest? = nil
    
    func loadImage(url:URL)
    {
        request?.cancel()
        indicator.startAnimating()
        self.imageToShow.image = nil
        let req = DownloadManager.sharedDownloadManager().getImage(withAddressURL: url) { (image) in
            DispatchQueue.main.async {
                self.imageToShow.image = image
                self.indicator.stopAnimating()
            }
        }
        request = req
    }
}
