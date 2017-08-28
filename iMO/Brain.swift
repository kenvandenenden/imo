//
//  Brain.swift
//  iMO
//
//  Created by Ken Van den Enden on 24/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

class Brain {
    static let brain = Brain()
    
    var favorites: [Work]?
    
    static func addFavorite(work: Work) {
        brain.addFavorite(work: work)
    }
    
    static var favorites: [Work]? {
        return brain.favorites
    }
    
    private init() {
        if let workIds = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            
            let loadedFavorites = WorkRepository.redbubble.fetchWorkDetails(works: workIds)
            if let favorites = favorites {
                self.favorites = loadedFavorites + favorites
            } else {
                self.favorites = loadedFavorites
            }
        } else {
            self.favorites = [Work]()
        }
        
    }
    
//    convenience required init?(coder: NSCoder) {
//        guard let works = coder.decodeObject(forKey: "favorites") as? [Int] else { return nil }
//        
//        self.init(favorites: WorkRepository.redbubble.fetchWorkDetails(works: works))
//    }
//    
//    func encode(with coder: NSCoder) {
//        let data = favorites.map { $0.id }
//        coder.encode(data, forKey: "favorites")
//    }
    
    func addFavorite(work: Work) {
        if favorites == nil {
            favorites = [Work]()
        }
        favorites?.append(work)
        save()
    }
    
    func removeFavorite(work: Work) {
        if let index = favorites?.index(where: { $0.id == work.id }) {
            favorites?.remove(at: index)
            save()
        }
    }
    
    private func save() {
        let data = favorites?.map { $0.id }
        UserDefaults.standard.set(data, forKey: "favorites")
    }
}
