//
//  Work.swift
//  iMO
//
//  Created by Ken Van den Enden on 22/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

struct Work: Equatable {
    let id: Int
    let title: String
    let imageURL: URL
    
    static func ==(lhs: Work, rhs: Work) -> Bool {
        return lhs.id == rhs.id
    }
}
