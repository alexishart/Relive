//
//  EditViewController.swift
//  relive
//
//  Created by Alexis Hart on 7/28/17.
//  Copyright © 2017 Elizabeth McRae. All rights reserved.
//

import UIKit
import os.log


class EditViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var mainNameTextField: UITextField!
    @IBOutlet weak var sigNameTextField: UITextField!
    @IBOutlet weak var enterDataLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var photo: Photo?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNameTextField.delegate = self
        sigNameTextField.delegate = self

        // Do any additional setup after loading the view.
        
   
        
        if let photo = photo {
            navigationItem.title = photo.mainName
            mainNameTextField.text = photo.mainName
            sigNameTextField.text = photo.sigName
            imageView.image = photo.image
            
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        mainNameTextField.resignFirstResponder()
        sigNameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        enterDataLabel.text = mainNameTextField.text
        descriptionLabel.text = sigNameTextField.text
        
        updateSaveButtonState()
        navigationItem.title = textField.text
        
    }
    
    
    @IBAction func selectImageFromLibarary(_ sender: UITapGestureRecognizer) {
        print("entered method")
        mainNameTextField.resignFirstResponder()
        sigNameTextField.resignFirstResponder()
        
        print("method called")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let mainName = mainNameTextField.text ?? ""
        let image = imageView.image
        let sigName = sigNameTextField.text ?? ""
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        photo = Photo(mainName: mainName, image: image, sigName: sigName)

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
        
        //MARK: Private Methods
        
        private func updateSaveButtonState() {
            // Disable the Save button if the text field is empty.
            let text = mainNameTextField.text ?? ""
            saveButton.isEnabled = !text.isEmpty
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}





