//
//  Brain.swift
//  iMO
//
//  Created by Ken Van den Enden on 24/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

class Brain {
    static var favorites = [Work]()
    
    static func addFavorite(work: Work) {
        favorites.append(work)
    }
}
