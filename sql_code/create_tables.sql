CREATE DATABASE IF NOT EXISTS db_LibraryManagement;
USE db_LibraryManagement;

CREATE TABLE IF NOT EXISTS tbl_publisher (
    publisher_PublisherName VARCHAR(100) PRIMARY KEY,
    publisher_PublisherAddress VARCHAR(200) NOT NULL,
    publisher_PublisherPhone VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_book (
    book_BookID INT PRIMARY KEY AUTO_INCREMENT,
    book_Title VARCHAR(100) NOT NULL,
    book_PublisherName VARCHAR(100) NOT NULL,
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(100) NOT NULL,
    library_branch_BranchAddress VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_borrower (
    borrower_CardNo INT PRIMARY KEY AUTO_INCREMENT,
    borrower_BorrowerName VARCHAR(100) NOT NULL,
    borrower_BorrowerAddress VARCHAR(200) NOT NULL,
    borrower_BorrowerPhone VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT NOT NULL,
    book_loans_BranchID INT NOT NULL,
    book_loans_CardNo INT NOT NULL,
    book_loans_DateOut DATE NOT NULL,
    book_loans_DueDate DATE NOT NULL,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT NOT NULL,
    book_copies_BranchID INT NOT NULL,
    book_copies_No_Of_Copies INT NOT NULL,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT NOT NULL,
    book_authors_AuthorName VARCHAR(50) NOT NULL,
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE
);

