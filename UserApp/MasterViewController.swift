//
//  MasterViewController.swift
//  UserApp
//
//  Created by Fred Rajaona on 02/11/2016.
//  Copyright © 2016 Fred Rajaona. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var albumsViewController: AlbumsViewController? = nil
    var users = [User]()
    var store: Store!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.albumsViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? AlbumsViewController
        }
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        store = appDelegate.store
        store.userListListener = { [unowned self] users in
            self.users = users
            self.tableView.reloadData()
        }
        store.loadUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbums" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let user = users[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! AlbumsViewController
                controller.user = user
                controller.store = store
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let user = users[indexPath.row]
        cell.textLabel!.text = user.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



}

