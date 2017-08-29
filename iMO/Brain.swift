//
//  Brain.swift
//  iMO
//
//  Created by Ken Van den Enden on 24/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

protocol BrainDelegate: class {
    func didUpdateFavorites();
}

class Brain {
    static let brain = Brain()
    
    private var favorites: [Work]?
    
    static func setDelegate(_ delegate: BrainDelegate) {
        brain.delegate = delegate
    }
    
    private weak var delegate: BrainDelegate?
    
    static func addFavorite(work: Work) {
        brain.addFavorite(work: work)
    }
    
    static func removeFavorite(work: Work) {
        brain.removeFavorite(work: work)
    }
    
    static var favorites: [Work]? {
        return brain.favorites
    }
    
    private init() {
        if let workIds = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            DispatchQueue.global(qos: .userInitiated).async {
                let loadedFavorites = WorkRepository.redbubble.fetchWorkDetails(works: workIds)
                if let favorites = self.favorites {
                    self.favorites = loadedFavorites + favorites
                } else {
                    self.favorites = loadedFavorites
                }
                self.delegate?.didUpdateFavorites()
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
    
    private func addFavorite(work: Work) {
        if favorites == nil {
            favorites = [Work]()
        }
        favorites?.append(work)
        save()
        delegate?.didUpdateFavorites()
    }
    
    private func removeFavorite(work: Work) {
        if let index = favorites?.index(where: { $0.id == work.id }) {
            favorites?.remove(at: index)
            save()
            delegate?.didUpdateFavorites()
        }
    }
    
    private func save() {
        let data = favorites?.map { $0.id }
        UserDefaults.standard.set(data, forKey: "favorites")
    }
}
