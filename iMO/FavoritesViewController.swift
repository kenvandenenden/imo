//
//  FavoritesViewController.swift
//  iMO
//
//  Created by Ken Van den Enden on 25/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit

class FavoritesViewController: GridViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.works = Brain.favorites
    }
}