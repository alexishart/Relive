//
//  mainScreenTableViewController.swift
//  relive
//
//  Created by Alexis Hart on 7/28/17.
//  Copyright © 2017 Elizabeth McRae. All rights reserved.
//

import UIKit

class mainScreenTableViewController: UITableViewController {
    
    var MiscPhotos = [Photo]()
    var familyPhotos = [Photo]()
    var placesPhotos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSamplePhotos()

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
        return 3
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "miscSegue" {
            let destNC = segue.destination as! UINavigationController
            let targetC = destNC.topViewController as! PhotoTableViewController
            targetC.currentState = "Misc Photos"
        }
        else if segue.identifier == "placesSegue" {
            let destNC = segue.destination as! UINavigationController
            let targetC = destNC.topViewController as! PhotoTableViewController
            targetC.currentState = "Places Photos"
            
        }
        else if segue.identifier == "peopleSegue" {
            let destNC = segue.destination as! UINavigationController
            let targetC = destNC.topViewController as! PhotoTableViewController
            targetC.currentState = "Family and Friend Photos"
            
        }

        
        
   
 
    }
    
    
    private func loadSamplePhotos() {
        let photo1 = UIImage(named: "foodimage")
        let photo2 = UIImage(named: "placeImage")
        let photo3 = UIImage(named: "familyImage")
        
        guard let photoExample = Photo(mainName: "food", image: photo1, sigName: "favorite meal") else {
            fatalError("Unable to instantiate photo1")
        }
        guard let photoExample2 = Photo(mainName: "this is place", image: photo2, sigName: "PLace") else {
            fatalError("Unable to instantiate photo1")
        }
        guard let photoExample3 = Photo(mainName: "family member", image: photo3, sigName: "family") else {
            fatalError("Unable to instantiate photo1")
        }
        MiscPhotos += [photoExample]
        familyPhotos += [photoExample3]
        placesPhotos += [photoExample2]
        
        
    }

    
    

}
