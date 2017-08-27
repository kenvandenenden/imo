//
//  WorkRepository.swift
//  iMO
//
//  Created by Ken Van den Enden on 22/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import Foundation

class WorkRepository {
    static let foundFeed = WorkRepository(url: URL(string: "https://icarus.redbubble.net/v2/collections/found/feed?country=AU&currency=AUD")!)
    
    var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetchWorks(limit: Int = 48) -> [Work] {
        guard let url = URL(string: self.url.absoluteString + "&count=\(limit)"),
        let json = try? String(contentsOf: url) else {
            return [Work]()
        }
        
        let works = decodeWorks(json)
        return works
    }
    
    private func decodeWorks(_ jsonString: String) -> [Work] {
        guard let jsonData = jsonString.data(using: .utf8),
        let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String:AnyObject],
        let data = json?["data"] as? [[String:AnyObject]] else {
            return [Work]()
        }
        
        let works: [Work] = data.map {
            let id = $0["work_id"] as! String
            let title = $0["title"] as! String
            let imageURL = $0["work_url"] as! String
            
            return Work(
                id: Int(id)!,
                title: title,
                imageURL: URL(string: imageURL)!
            )
        }
        return works
    }
}
