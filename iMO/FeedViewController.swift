//
//  FeedViewController.swift
//  iMO
//
//  Created by Ken Van den Enden on 25/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit

class FeedViewController: GridViewController {
    
    var personalisedFeed = false
    
    var foundFeedWorks: [Work]?
    
    @IBAction func changeFeed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 { // Your Feed
            personalisedFeed = true
        } else {
            personalisedFeed = false
        }
        works = nil
        loadWorks()
    }
    
    var numberOfWorks = 96
    let workRepository = WorkRepository.redbubble
    let recommendationRepository = RecommendationRepository.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorks()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        loadWorks()
    }
    
    func loadWorks() {
        if personalisedFeed {
            loadYourFeedWorks()
        } else {
            loadFoundFeedWorks()
        }
    }
    
    func loadFoundFeedWorks() {
        DispatchQueue.global(qos: .userInitiated).async {
            if self.foundFeedWorks == nil {
                self.foundFeedWorks = self.workRepository.fetchWorks(limit: self.numberOfWorks)
            }
            DispatchQueue.main.async {
                self.works = self.foundFeedWorks
            }
        }
    }
    
    func loadYourFeedWorks() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let favorites = Brain.favorites {
                let works = self.recommendationRepository.recommendedWorks(for: favorites, limit: self.numberOfWorks)
                
                DispatchQueue.main.async {
                    //                self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                    self.works = works
                }
            }
        }
    }
}
