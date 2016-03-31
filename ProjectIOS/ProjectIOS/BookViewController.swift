//
//  BookViewController.swift
//  ProjectIOS
//
//  Created by user116475 on 3/30/16.
//  Copyright © 2016 user116475. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // MARK: Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var writerTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    // This value is either passed by ‘MealTableViewController‘ in ‘prepareForSegue(_:sender:)‘ or constructed as part of adding a new meal
    var book: Book?
    var category : Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        titleTextField.delegate = self
        
        // Set up views if editing an existing Book.
        if let book = book {
            navigationItem.title = book.title
            titleTextField.text = book.title
            writerTextField.text = book.writer
            photoImageView.image = book.cover
            ratingControl.rating = book.rating
        }
        
        // Enable the Save button only if the text field has a valid Book name.
        checkValidBookName()
        
        print("Category: ",category.name)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidBookName()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dimiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidBookName(){
        // Disable the Save button if the text field is empty
        let text = titleTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        titleTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure viewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController  // in case of the add (modal) a new Navigation Bar is used, presented by UINavi...
        if isPresentingInAddMealMode{
            dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    // This method lets you configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let title = titleTextField.text ?? ""
            let writer = writerTextField.text ?? ""
            let cover = photoImageView.image
            let rating = ratingControl.rating
            
            // Set the meal to be passed to MealTableViewController after the unwind segue
            book = Book(title: title, writer: writer, cover: cover, rating: rating)
            
        }
    }
    
    
    
    
    
    
    
}


