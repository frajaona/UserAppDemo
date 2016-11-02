//
//  Store.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//

import Foundation
import UIKit

class Store {
    
    static let userListUrl = "https://jsonplaceholder.typicode.com/users"
    static let photoListUrl = "https://jsonplaceholder.typicode.com/albums/%s/photos"
    static let albumListUrl = "https://jsonplaceholder.typicode.com/users/%s/albums"
    
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private var userListDataTask: URLSessionDataTask?
    var userListListener: (([User]) -> Void)?
    
    private var albumListDataTask: URLSessionDataTask?
    var albumListListener: (([Album]) -> Void)?
    
    private var photoListDataTask: URLSessionDataTask?
    var photoListListener: (([Photo]) -> Void)?
    
    func loadUsers() {
        if let task = userListDataTask {
            task.cancel()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: Store.userListUrl)
        userListDataTask = defaultSession.dataTask(with: url!) {
            data, response, error in
            // Called in a background thread
            var result: [User]?
            if let error = error {
                print(error.localizedDescription)
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                result = self.parseUserListResponse(data)
            }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if result != nil, let listener = self.userListListener {
                    listener(result!)
                }
            }
        }
        userListDataTask?.resume()

    }
    
    func loadAlbums(of user: User) {
        if let task = albumListDataTask {
            task.cancel()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: Store.albumListUrl.replacingOccurrences(of: "%s", with: "\(user.id)"))
        albumListDataTask = defaultSession.dataTask(with: url!) {
            data, response, error in
            // Called in a background thread
            var result: [Album]?
            if let error = error {
                print(error.localizedDescription)
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                result = self.parseAlbumListResponse(data)
            }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if result != nil, let listener = self.albumListListener {
                    listener(result!)
                }
            }
        }
        albumListDataTask?.resume()
    }
    
    func loadPhotos(of album: Album) {
        if let task = photoListDataTask {
            task.cancel()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: Store.photoListUrl.replacingOccurrences(of: "%s", with: "\(album.id)"))
        albumListDataTask = defaultSession.dataTask(with: url!) {
            data, response, error in
            // Called in a background thread
            var result: [Photo]?
            if let error = error {
                print(error.localizedDescription)
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                result = self.parsePhotoListResponse(data)
            }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if result != nil, let listener = self.photoListListener {
                    listener(result!)
                }
            }
        }
        albumListDataTask?.resume()
    }
    
    
    
    func parseUserListResponse(_ data: Data?) -> [User] {
        var json: [Any]?
        guard let data = data else {
            return []
        }
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [Any]
        } catch {
            print(error)
        }
        if let list = json {
            return list.flatMap { object in
                if let jsonUser = object as? [String: Any] {
                     return User(json: jsonUser)
                }
                return nil
            }
        }
        return []
    }
    
    func parseAlbumListResponse(_ data: Data?) -> [Album] {
        var json: [Any]?
        guard let data = data else {
            return []
        }
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [Any]
        } catch {
            print(error)
        }
        if let list = json {
            return list.flatMap { object in
                if let jsonUser = object as? [String: Any] {
                    return Album(json: jsonUser)
                }
                return nil
            }
        }
        return []
    }
    
    func parsePhotoListResponse(_ data: Data?) -> [Photo] {
        var json: [Any]?
        guard let data = data else {
            return []
        }
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [Any]
        } catch {
            print(error)
        }
        if let list = json {
            return list.flatMap { object in
                if let jsonUser = object as? [String: Any] {
                    return Photo(json: jsonUser)
                }
                return nil
            }
        }
        return []
    }
}
