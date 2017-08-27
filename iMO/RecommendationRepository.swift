//
//  RecommendationRepository.swift
//  iMO
//
//  Created by Ken Van den Enden on 23/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation
import Apollo

class RecommendationRepository {
    private let repository = WorkRepository.foundFeed
    
    private let apollo = ApolloClient(url: URL(string: "https://guru-playground.us-east-1.staging.bubblesof.red/graphql")!)
    
    func recommendedWorks(for work: Work, limit: Int = 24) -> [Work] {
        return recommendations(for: work, limit: limit)
    }
    
    func recommendedWorks(for works: [Work], limit: Int = 24) -> [Work] {
        return recommendations(for: works, limit: limit)
    }
    
    private func recommendations(for work: Work, limit: Int) -> [Work] {
        let dispatch = DispatchGroup()
        dispatch.enter()
        
        var recommendedWorks = [Work]()
        apollo.fetch(query: WorkRecommendationsQuery(id: String(work.id), limit: 24)) { (result, error) in
            if let recommendations = result?.data?.work?.recommendations {
            
                let rec: [Work] = recommendations.map {
                    let work = $0!.work!
                    
                    let id = work.id!
                    let title = work.title
                    let link = work.image.link
                    
                    return Work(id: Int(id)!, title: title, imageURL: URL(string: link)!)
                }
                
                recommendedWorks.append(contentsOf: rec)
            }
            dispatch.leave()
        }
        dispatch.wait()
        return sample(recommendedWorks, n: limit)
    }
    
    private func recommendations(for works: [Work], limit: Int) -> [Work] {
        let dispatch = DispatchGroup()
        
        var recommendedWorks = [Work]()
        
        for id in works.map({ work in String(work.id) }) {
            dispatch.enter()
            apollo.fetch(query: WorkRecommendationsQuery(id: id, limit: 24)) { (result, error) in
                if let recommendations = result?.data?.work?.recommendations {
                    let rec: [Work] = recommendations.flatMap{$0}.map {
                        let work = $0.work!
                        
                        let id = work.id!
                        let title = work.title
                        let link = work.image.link
                        
                        return Work(id: Int(id)!, title: title, imageURL: URL(string: link)!)
                    }
                    
                    recommendedWorks.append(contentsOf: rec)
                }
                dispatch.leave()
            }
        }
        dispatch.wait()
        //        TODO: Remove duplicates
        
        return sample(recommendedWorks, n: limit)
    }
    
    private func sample<T: Any>(_ array: [T], n: Int = 1) -> [T] {
        return Array(shuffle(array).prefix(n))
    }
    
    private func shuffle<T: Any>(_ array: [T]) -> [T] {
        return array.sorted { _,_ in arc4random() % 2 == 0 }
    }
}
