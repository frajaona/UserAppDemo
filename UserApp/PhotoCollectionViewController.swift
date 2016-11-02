//
//  PhotoCollectionViewController.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    var album: Album? {
        didSet {
            // Update the view.
            self.configureView()
            // Force restarting request when user is set
            requestStarted = false
            self.startRequest()
        }
    }
    
    var store: Store? {
        didSet {
            self.startRequest()
        }
    }
    
    var photos = [Photo]()
    var requestStarted = false
    
    func configureView() {
        if let album = self.album {
            self.navigationItem.title = album.title
        }
    }
    
    func startRequest() {
        if requestStarted {
            return
        }
        guard let store = store else {
            return
        }
        store.photoListListener = { [unowned self] photos in
            self.photos = photos
            self.collectionView?.reloadData()
        }
        if let album = album {
            store.loadPhotos(of: album)
            requestStarted = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.blue
        // Configure the cell
    
        return cell
    }

}
