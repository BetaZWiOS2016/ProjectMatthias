//
//  Category.swift
//  ProjectIOS
//
//  Created by user116475 on 3/30/16.
//  Copyright © 2016 user116475. All rights reserved.
//

import UIKit

class Category: NSObject,NSCoding{
    
    // MARK: Properties
    
    var name: String
    var banner: UIImage
    var books: [Book]?
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let bannerKey = "banner"
        static let booksKey = "books"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("data")
    
    init?(name:String, books: [Book], banner: UIImage){
        self.name = name
        self.banner = banner
        self.books = books
        //super.init()
    }
    
    func addBook(book: Book){
        books?.append(book)
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name,forKey: PropertyKey.nameKey)
        aCoder.encodeObject(banner,forKey: PropertyKey.bannerKey)
        aCoder.encodeObject(books,forKey: PropertyKey.booksKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because cover is an optional property of Book, use conditional cast.
        let banner = aDecoder.decodeObjectForKey(PropertyKey.bannerKey) as! UIImage
        
        let books = aDecoder.decodeObjectForKey(PropertyKey.booksKey) as! [Book]
        
        self.init(name:name, books:books, banner:banner)
    }
}

