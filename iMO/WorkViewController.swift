//
//  WorkViewController.swift
//  iMO
//
//  Created by Ken Van den Enden on 22/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit

class WorkViewController: GridViewController {
    @IBAction func favoriteWork(_ sender: Any) {
        if let work = self.work {
            if Brain.favorites?.contains(work) ?? false {
                Brain.removeFavorite(work: work)
            } else {
                Brain.addFavorite(work: work)
            }
            updateUI()
            print(Brain.favorites?.map { work in work.id } ?? "no favorites")
        }
    }
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var numberOfRecommendations = 96
    
    var work: Work? {
        didSet {
            title = work?.title
            updateUI()
            updateRecommendations(work: work)
        }
    }
    
    override func updateUI() {
        super.updateUI()
        
        if let work = self.work, let favorites = Brain.favorites {
            DispatchQueue.main.async { [weak self] in
                if favorites.contains(work) {
                    self?.favoriteButton.image = UIImage(named: "icon-heart-filled")
//                    self?.favoriteButton.tintColor = UIColor.RBRed()
                } else {
                    self?.favoriteButton.image = UIImage(named: "icon-heart")
//                    self?.favoriteButton.tintColor = nil
                }
            }
        }
    }
    
    let recommendationRepository = RecommendationRepository()
    
    private func updateRecommendations(work: Work? = nil) {
        let limit = numberOfRecommendations
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            var works: [Work]?
            if let work = work {
                works = self?.recommendationRepository.recommendedWorks(for: work, limit: limit)
            }
            
            DispatchQueue.main.async {
                if work == self?.work {
                    self?.works = works
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource protocol
extension WorkViewController {
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView: UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath as IndexPath) as! WorkCollectionViewCell
            cell.work = work
            reusableView = cell
        }
        
        return reusableView!
    }
}
