//
//  WorkRepository.swift
//  iMO
//
//  Created by Ken Van den Enden on 22/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

class WorkRepository {
    static let redbubble = WorkRepository(feedUrl: URL(string: "https://icarus.redbubble.net/v2/collections/found/feed?country=AU&currency=AUD")!)
    
    private var feedUrl: URL
    
    init(feedUrl: URL) {
        self.feedUrl = feedUrl
    }
    
    func fetchWorks(limit: Int = 48) -> [Work] {
        guard let url = URL(string: self.feedUrl.absoluteString + "&count=\(limit)"),
        let json = try? String(contentsOf: url) else {
            return [Work]()
        }
        
        let works = decodeWorks(json)
        return works
    }
    
    func fetchWorkDetails(works: [Int]) -> [Work] {
        return RecommendationRepository.guru.works(ids: works)
    }
    
    private func decodeWorks(_ jsonString: String) -> [Work] {
        guard let jsonData = jsonString.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String:AnyObject],
            let data = json?["data"] as? [[String:AnyObject]] else { return [Work]() }
        
        let works: [Work] = data.map { decode(work: $0) }.flatMap { $0 }
        return fetchWorkDetails(works: works.map { $0.id })
//        return works
    }
    
    private func decode(work: [String:AnyObject]) -> Work? {
        guard let id = work["work_id"] as? String,
        let title = work["title"] as? String,
        let imageURL = work["work_url"] as? String else {
            return nil
        }
        
        return Work(
            id: Int(id)!,
            title: title,
            imageURL: URL(string: imageURL)!
        )
    }
}
