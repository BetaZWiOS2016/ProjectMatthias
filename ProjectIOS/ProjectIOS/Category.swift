//
//  Category.swift
//  ProjectIOS
//
//  Created by user116475 on 3/30/16.
//  Copyright © 2016 user116475. All rights reserved.
//

import UIKit

class Category{
    
    // MARK: Properties
    var name: String
    var banner: UIImage
    var books: [Book]
    
    init?(name:String, books: [Book], banner: UIImage){
        self.name = name
        self.banner = banner
        self.books = books
    }
    
    func addBook(book: Book){
        books.append(book)
    }
}

