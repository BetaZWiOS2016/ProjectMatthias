//
//  Book.swift
//  ProjectIOS
//
//  Created by user116475 on 3/30/16.
//  Copyright © 2016 user116475. All rights reserved.
//

import UIKit

class Book: NSObject, NSCoding{
    
    // MARK: Properties
    
    var title: String
    var writer: String
    var cover: UIImage?
    var rating: Int
    
    // MARK: Types
    
    struct PropertyKey {
        static let titleKey = "title"
        static let writerKey = "writer"
        static let coverKey = "cover"
        static let ratingKey = "rating"
    }
    
    // MARK: Initialization
    
    init?(title:String, writer: String, cover: UIImage?,rating:Int){
        // Initialize stored properties
        self.title = title
        self.writer = writer
        self.cover = cover
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative
        if title.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title,forKey: PropertyKey.titleKey)
        aCoder.encodeObject(writer,forKey: PropertyKey.writerKey)
        aCoder.encodeObject(cover,forKey: PropertyKey.coverKey)
        aCoder.encodeInteger(rating,forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let writer = aDecoder.decodeObjectForKey(PropertyKey.writerKey) as! String
        
        // Because cover is an optional property of Book, use conditional cast.
        let cover = aDecoder.decodeObjectForKey(PropertyKey.coverKey) as! UIImage
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        self.init(title:title, writer: writer, cover:cover, rating: rating)
    }
    
    
}

