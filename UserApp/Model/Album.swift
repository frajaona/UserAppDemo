//
//  Album.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//

import Foundation

/*
 
 {
 "userId": 1,
 "id": 1,
 "title": "quidem molestiae enim"
 }
 
 */


struct Album {
    let userId: Int
    let id: Int
    let title: String
    
    init?(json: [String: Any]) {
        guard let userId = json["userId"] as? Int,
            let id = json["id"] as? Int,
            let title = json["title"] as? String
            else {
                return nil
        }
        
        self.userId = userId
        self.id = id
        self.title = title
    }
}
