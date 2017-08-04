//
//  PhotoTableViewController.swift
//  relive
//
//  Created by Elizabeth McRae on 7/27/17.
//  Copyright © 2017 Elizabeth McRae. All rights reserved.
//

import UIKit
import os.log

class PhotoTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var photos = [Photo]()
    var MiscPhotos = [Photo]()
    var familyPhotos = [Photo]()
    var placesPhotos = [Photo]()
    var currentState = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationItem.leftBarButtonItem = editButtonItem
        
        self.navigationItem.title = currentState
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target:self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        
        if let savedPhotos = loadPhotos() {
            print(savedPhotos.count)
            photos += savedPhotos
        }
        else {
            // Load the sample data.
            loadSamplePhotosForAlll()
    
        }

        
        
       
    }
    
    func back() {
        savePhotos()
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            fatalError("this didnt work")
        }
        let photoExample = photos[indexPath.row]
        
        cell.mainNameLabel.text = photoExample.mainName
        cell.photoImageView.image = photoExample.image
        cell.sigNameLabel.text = photoExample.sigName
        

        return cell
    }
    
    @IBAction func unwindToPhotoList(sender: UIStoryboardSegue) {
        savePhotos()
        if let sourceViewController = sender.source as? EditViewController, let photo = sourceViewController.photo {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                photos[selectedIndexPath.row] = photo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: photos.count, section: 0)
                
                photos.append(photo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        
        
    }

    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            photos.remove(at: indexPath.row)
            savePhotos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "addItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let photoDetailViewController = segue.destination as? EditViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPhotoCell = sender as? PhotoTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for:selectedPhotoCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPhoto = photos[indexPath.row]
            photoDetailViewController.photo = selectedPhoto
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }


//MARK: Private methods
    private func loadSamplePhotosForAlll() {
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
        
        if currentState == "Misc Photos" {
            print("in sample load misc")
            photos = MiscPhotos
        }
        else if currentState == "Family and Friend Photos" {
            print("in sampled load for family")
            photos = familyPhotos
        }
        else {
            photos = placesPhotos
            print("in sample load for places")
        }
        
        
    }

    private func loadSamplePhotos() {
        let photo1 = UIImage(named: "foodimage")
        
        guard let photoExample = Photo(mainName: "food", image: photo1, sigName: "favorite meal") else {
            fatalError("Unable to instantiate photo1")
        }
        
        photos += [photoExample]
        
      
    }
    
    private func savePhotos() {
        
        
        if currentState == "Misc Photos" {
            
            let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject(photos, toFile: Photo.ArchiveURLMisc.path)
            if isSuccessfulSave2 {
                os_log("Photos successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save photos...", log: OSLog.default, type: .error)
            }
            
            print("saved photos for misc")
            
            
        }
        else if currentState == "Family and Friend Photos" {
            print("entered the correct area")
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(photos, toFile: Photo.ArchiveURLFamily.path)
            if isSuccessfulSave {
                os_log("Photos successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save photos...", log: OSLog.default, type: .error)
            }
             print("saved photos for family")
        }
        else {
            let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject(photos, toFile: Photo.ArchiveURLPlaces.path)
            if isSuccessfulSave3 {
                os_log("Photos successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save photos...", log: OSLog.default, type: .error)
            }
             print("saved photos for places")
            
        }
       
    }
    
    private func loadPhotos() -> [Photo]?  {
        if currentState == "Misc Photos" {
            print("loaded misc")
            return NSKeyedUnarchiver.unarchiveObject(withFile: Photo.ArchiveURLMisc.path) as? [Photo]

        }
        else if currentState == "Family and Friend Photos" {
            print("loaded old family")
            return NSKeyedUnarchiver.unarchiveObject(withFile: Photo.ArchiveURLFamily.path) as? [Photo]

        }
        else {
            print("loaded old places")
            return NSKeyedUnarchiver.unarchiveObject(withFile: Photo.ArchiveURLPlaces.path) as? [Photo]

            
        }
    }
}
