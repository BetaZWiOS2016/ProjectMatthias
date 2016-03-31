//
//  BookTableViewController.swift
//  ProjectIOS
//
//  Created by user116475 on 3/30/16.
//  Copyright © 2016 user116475. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var books = [Book]()
    var data : [Category]!

    var category : Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the dit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved books, otherwise load sample data.
        loadBooks()
        
       
    }
    
    func loadBooks(){
        
        print(category?.books?.first?.title)
        
        books = (category?.books)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BookTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        
        // Fetches the appropriate meal for the data source layout
        let book = books[indexPath.row]
        
        cell.titleLabel.text = book.title
        cell.writerLabel.text = book.writer
        cell.photoImageView.image = book.cover
        cell.ratingControl.rating = book.rating
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            books.removeAtIndex(indexPath.row)
            saveData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let bookDetailViewController = segue.destinationViewController as! BookViewController
            if let selectedBookCell = sender as? BookTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedBookCell)!
                let selectedBook = books[indexPath.row]
                bookDetailViewController.book = selectedBook
                bookDetailViewController.category = category
            }
        }
            
        else if segue.identifier == "AddItem"{
            print("Adding new book.")
            
            let navViewController = segue.destinationViewController as! UINavigationController
            let bookDetailViewController = navViewController.viewControllers.first as! BookViewController
            bookDetailViewController.category = category
        }
    }
    
    
    @IBAction func unwindToBookList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.sourceViewController as? BookViewController, book = sourceViewController.book{
            //print("Index:", data.indexOf(category))
            data.removeAtIndex(data.indexOf(category)!)
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // Update an existing book.
                books[selectedIndexPath.row] = book
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                // Add a new book.
                let newIndexPath = NSIndexPath(forRow: books.count, inSection: 0)
                books.append(book)
                category.addBook(book)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the books.
            
            data.append(category)
            
            saveData()
        }
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        print("Back clicked")
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    // MARK: NSCoding
    
    func saveData(){
        data.sortInPlace({$0.name < $1.name})
        /*for category in data{
            print(category.books)
        }*/
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(data, toFile: Category.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save books")
        }
        
    }
    
    
    
    
    
}
