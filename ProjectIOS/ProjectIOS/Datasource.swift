//
//  Datasource.swift
//  ProjectIOS
//
//  Created by user116475 on 3/31/16.
//  Copyright © 2016 user116475. All rights reserved.
//

import UIKit

class Datasource{
    
    
    
    
    static func preloadData() ->[Category]{
        
        var categories = [Category]()
        
        let books = [Book]()
        
        let cover1 = UIImage(named:"book1")!
        let book1 = Book(title: "Harry Potter and the Sorcerer's Stone(2001)",writer:"J.K. Rowling", cover: cover1, rating: 4)!
        
        let cover2 = UIImage(named: "book2")!
        let book2 = Book(title: "A Game of Thrones", writer: "George R.R. Martin", cover: cover2, rating: 5)!
        
        let cover3 = UIImage(named: "book3")
        let book3 = Book(title: "The Da Vinci Code", writer: "Dan Brown", cover: cover3, rating: 3)!
        
        
        
        let photo1 = UIImage(named:"adventureGenre")!
        let category1 = Category(name: "Adventure", books: books, banner: photo1)!
        
        let photo2 = UIImage(named:"classicsGenre")!
        let category2 = Category(name: "Classics",books:books,banner:photo2)!
        
        let photo3 = UIImage(named:"fairytalesGenre")!
        let category3 = Category(name: "Fairy Tales",books:books,banner:photo3)!
        
        let photo4 = UIImage(named:"fantasyGenre")!
        var books4 = [Book]()
        books4 += [book1,book2]
        let category4 = Category(name: "Fantasy",books:books4,banner:photo4)!
        
        let photo5 = UIImage(named:"graphicnovelsGenre")!
        let category5 = Category(name: "Graphic Novels",books:books,banner:photo5)!
        
        let photo6 = UIImage(named:"historicalfictionGenre")!
        let category6 = Category(name: "Historical Fiction",books:books,banner:photo6)!
        
        let photo7 = UIImage(named:"humorGenre")!
        let category7 = Category(name: "Humor",books:books,banner:photo7)!
        
        let photo8 = UIImage(named:"mysteryGenre")!
        var books5 = [Book]()
        books5 += [book3]
        let category8 = Category(name: "Mystery",books:books5,banner:photo8)!
        
        let photo9 = UIImage(named:"realisticfictionGenre")!
        let category9 = Category(name: "Realistic Fiction",books:books,banner:photo9)!
        
        let photo10 = UIImage(named:"scaryGenre")!
        let category10 = Category(name: "Scary",books:books,banner:photo10)!
        
        let photo11 = UIImage(named:"sciencefictionGenre")!
        let category11 = Category(name: "Science Fiction",books:books,banner:photo11)!
        
        let photo12 = UIImage(named:"sportsGenre")!
        let category12 = Category(name: "Sports",books:books,banner:photo12)!
        
        
        
        
        categories += [category1,category2,category3,category4, category5, category6, category7, category8, category9, category10, category11, category12]
        categories.sortInPlace({$0.name < $1.name})
        return categories
    }
    
}
