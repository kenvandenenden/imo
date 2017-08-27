//
//  WorkCollectionViewCell.swift
//  iMO
//
//  Created by Ken Van den Enden on 22/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit
import Kingfisher

class WorkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var workView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var work: Work? {
        didSet {
            updateWorkImage()
        }
    }
    
    private func updateWorkImage() {
        spinner?.startAnimating()
        self.workView.image = nil
        guard let work = self.work else {
            return
        }
        
//        self.workView.kf.indicatorType = .activity
        self.workView.kf.setImage(with: work.imageURL, options: [.transition(.fade(0.2))]) { (_,_,_,_) in
            self.spinner?.stopAnimating()
        }
    }
}
