USE db_LibraryManagement;

-- Show all tables
SHOW TABLES;

-- Show data from each table:

-- Publisher table
SELECT * FROM tbl_publisher;

-- Book table
SELECT * FROM tbl_book;

-- Library branch table
SELECT * FROM tbl_library_branch;

-- Borrower table
SELECT * FROM tbl_borrower;

-- Book loans table
SELECT * FROM tbl_book_loans;

-- Book copies table
SELECT * FROM tbl_book_copies;

-- Book authors table
SELECT * FROM tbl_book_authors;

-- All books and publisher information
SELECT tb.book_BookID, tb.book_Title, tb.book_PublisherName, tp.publisher_PublisherAddress, tp.publisher_PublisherPhone 
FROM tbl_publisher AS tp
JOIN tbl_book AS tb
ON tp.publisher_PublisherName = tb.book_PublisherName
ORDER BY book_BookID;

-- Books that were published by a particular publisher 
SELECT tb.book_BookID, tb.book_Title, tb.book_PublisherName, tp.publisher_PublisherAddress, tp.publisher_PublisherPhone 
FROM tbl_publisher AS tp
JOIN tbl_book AS tb
ON tp.publisher_PublisherName = tb.book_PublisherName
HAVING tb.book_PublisherName = 'DAW Books'
ORDER BY book_BookID;

-- Number of books taken by each person  
SELECT book_loans_CardNo, COUNT(book_loans_BookId) 
FROM tbl_book_loans 
GROUP BY book_loans_CardNo;

-- Number of people in fee impose list, branch wise
SELECT book_loans_BranchID, COUNT(*) 
FROM tbl_book_loans 
WHERE book_loans_DueDate < CURRENT_DATE() 
GROUP BY book_loans_BranchID;

-- Disable safe mode to update the data
SET sql_safe_updates = 0;

-- Updating the number of copies remaining
UPDATE tbl_book_copies AS bc
JOIN tbl_book_loans AS bl 
ON bc.book_copies_BookID = bl.book_loans_BookID
SET bc.book_copies_No_Of_Copies = CASE 
WHEN bc.book_copies_No_Of_Copies > 0 THEN bc.book_copies_No_Of_Copies - 1
ELSE 0
END;

