//
//  Photo.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//

import Foundation


/*
 
 {
 "albumId": 1,
 "id": 1,
 "title": "accusamus beatae ad facilis cum similique qui sunt",
 "url": "http://placehold.it/600/92c952",
 "thumbnailUrl": "http://placehold.it/150/30ac17"
 }
 
 */

struct Photo {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init?(json: [String: Any]) {
        guard let albumId = json["albumId"] as? Int,
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let url = json["url"] as? String,
            let thumbnailUrl = json["thumbnailUrl"] as? String
            else {
                return nil
        }
        
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
