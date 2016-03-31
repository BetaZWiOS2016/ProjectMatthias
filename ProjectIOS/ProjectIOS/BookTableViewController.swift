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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the dit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedBooks = loadBooks(){
            books += savedBooks
        }
            
        else{
            // Load the sample data
            loadSampleBooks()
        }
       
    }
    
    func loadSampleBooks(){
        let photo1 = UIImage(named:"book1")!
        let book1 = Book(title: "Harry Potter and the Sorcerer's Stone(2001)",writer:"J.K. Rowling", cover: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "book2")!
        let book2 = Book(title: "A Game of Thrones", writer: "George R.R. Martin", cover: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "book3")
        let book3 = Book(title: "The Da Vinci Code", writer: "Dan Brown", cover: photo3, rating: 3)!
        
        books += [book1, book2, book3]
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
            saveBooks()
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
            }
        }
            
        else if segue.identifier == "AddItem"{
            print("Adding new book.")
        }
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? BookViewController, book = sourceViewController.book{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // Update an existing book.
                books[selectedIndexPath.row] = book
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                // Add a new book.
                let newIndexPath = NSIndexPath(forRow: books.count, inSection: 0)
                books.append(book)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the books.
            saveBooks()
        }
    }
    
    // MARK: NSCoding
    
    func saveBooks(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(books, toFile: Book.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save books")
        }
    }
    
    func loadBooks() ->[Book]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Book.ArchiveURL.path!) as? [Book]
    }
    
    
    
}
