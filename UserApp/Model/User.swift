//
//  User.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//


/*
 
 {
 "id": 1,
 "name": "Leanne Graham",
 "username": "Bret",
 "email": "Sincere@april.biz",
 "address": {
 "street": "Kulas Light",
 "suite": "Apt. 556",
 "city": "Gwenborough",
 "zipcode": "92998-3874",
 "geo": {
 "lat": "-37.3159",
 "lng": "81.1496"
 }
 },
 "phone": "1-770-736-8031 x56442",
 "website": "hildegard.org",
 "company": {
 "name": "Romaguera-Crona",
 "catchPhrase": "Multi-layered client-server neural-net",
 "bs": "harness real-time e-markets"
 }
 }
 
 
 */


import Foundation

struct User {
    let id: Int
    let name: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.name = name
    }
}
