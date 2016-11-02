//
//  AlbumsViewController.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//

import UIKit

class AlbumsViewController: UITableViewController {

    var user: User? {
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
    
    var albums = [Album]()
    var requestStarted = false
    
    func configureView() {
        if let user = self.user {
            self.navigationItem.title = user.name
        }
    }
    
    func startRequest() {
        if requestStarted {
            return
        }
        guard let store = store else {
            return
        }
        store.albumListListener = { [unowned self] albums in
            self.albums = albums
            self.tableView.reloadData()
        }
        if let user = user {
            store.loadAlbums(of: user)
            requestStarted = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let album = albums[indexPath.row]
        cell.textLabel!.text = album.title
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showPhotos" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let album = albums[indexPath.row]
                let controller = segue.destination as! PhotoCollectionViewController
                controller.album = album
                controller.store = store
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    

}
