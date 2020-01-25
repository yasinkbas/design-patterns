import UIKit

protocol Book: class {
    var name: String { get set }
    func read()
}

final class History: Book {
    var name: String
    var author: String
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
    }
    
    func read() {
        print("Reading the \(name) book about history written by \(author)")
    }
}

final class Science: Book {
    var name: String
    var author: String
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
    }
    
    func read() {
        print("Reading the \(name) book about science written by \(author)")
    }
}

final class Drama: Book {
    var name: String
    var author: String
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
    }
    
    func read() {
        print("Reading the \(name) book about drama written by \(author)")
    }
}

final class Bookshelf: Book {
    var name: String
    lazy var books: [Book] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addBook(_ book: Book...) {
        book.forEach{ books.append($0) }
    }
    
    func read() {
        print("Reading all books in the bookshelf 🤘🏻")
        for book in books {
            book.read()
        }
    }
}

var book1 = History(name: "history", author: "author1")
var book2 = Science(name: "science", author: "author2")
var book3 = Drama(name: "drama", author: "author3")

var bookshelf = Bookshelf(name: "bookshelf")
bookshelf.addBook(book1, book2, book3)
bookshelf.read()

