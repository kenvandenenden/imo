//
//  FavoritesViewController.swift
//  iMO
//
//  Created by Ken Van den Enden on 25/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit

class FavoritesViewController: GridViewController, BrainDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        Brain.setDelegate(self)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.works = Brain.favorites
            self.updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            self.works = Brain.favorites
            self.updateUI()
        }
    }
    
    func didUpdateFavorites() {
        self.works = Brain.favorites
        self.updateUI()
    }
}
