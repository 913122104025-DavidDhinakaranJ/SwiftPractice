struct Library {
    private var books: [Book] = []
    
    mutating func addBook(_ book: Book) { books.append(book) }
    func getBooks() -> [Book] { return books }
}

struct Book {
    private let title: String
    private let author: String
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
    
    func getTitle() -> String { return title }
    func getAuthor() -> String { return author }
}

//Books can exist without library
var book1 = Book(title: "Swift Programming", author: "Apple Inc.")
var book2 = Book(title: "Data Structures", author: "E.Balaguru")

//Library contains Books
var library1 = Library()
library1.addBook(book1)
library1.addBook(book2)
