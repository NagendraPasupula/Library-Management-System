CREATE DATABASE LIBRARY;

USE LIBRARY;

CREATE TABLE BOOK(
Book_id NCHAR(10) NOT NULL,
Title VARCHAR(255),
CONSTRAINT pk_book PRIMARY KEY (Book_id)
 );
 
 CREATE TABLE BOOK_AUTHORS(
 Book_id NCHAR(10) NOT NULL,
 Author_name VARCHAR(200),
 Fname VARCHAR(100),
 Minit VARCHAR(50) DEFAULT NULL,
 Lname VARCHAR(100),
 CONSTRAINT pk_bookauthors PRIMARY KEY (Book_id,Author_name),
 CONSTRAINT fk_bookauthors FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
 );

 CREATE TABLE LIBRARY_BRANCH(
 Branch_id INTEGER,
 Branch_name VARCHAR(100),
 Address VARCHAR(200),
 CONSTRAINT pk_librarybranch PRIMARY KEY (Branch_id)
 );
 
 CREATE TABLE BOOK_COPIES(
 Book_id CHAR(10) NOT NULL,
 Branch_id INTEGER,
 No_of_copies INTEGER,
 CONSTRAINT pk_bookcopies PRIMARY KEY (Book_id,Branch_id),
 CONSTRAINT	fk_boookcopies FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id) ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT	fk_boookcopies1 FOREIGN KEY (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id) ON UPDATE CASCADE ON DELETE CASCADE
 );
 
 CREATE TABLE BORROWER(
Card_no INTEGER,
Fname VARCHAR(100),
Lname VARCHAR(100),
Address VARCHAR(200),
Phone VARCHAR(12),
CONSTRAINT pk_borrower PRIMARY KEY (Card_no)
 );
 
 CREATE TABLE BOOK_LOANS(
 Loan_id INTEGER,
Book_id  NCHAR(10) NOT NULL,
Branch_id INTEGER,
Card_no INTEGER,
Date_out DATE,
Due_date DATE,
Date_in DATE,
CONSTRAINT pk_bookloans PRIMARY KEY (Loan_id),
CONSTRAINT fk_bookloans FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id),
CONSTRAINT fk_bookloans1 FOREIGN KEY (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id),
CONSTRAINT fk_bookloans2 FOREIGN KEY (card_no) REFERENCES BORROWER(card_no)
 );
 
 CREATE TABLE FINES(
 Loan_id INTEGER NOT NULL,
 Fine_amt FLOAT(.2),
 Paid BOOLEAN,
 CONSTRAINT pk_fines PRIMARY KEY (Loan_id),
 CONSTRAINT fk_fines FOREIGN KEY (Loan_id) REFERENCES BOOK_LOANS(Loan_id)
 ); 

 
LOAD DATA INFILE 'E:/DB design/Project/book.csv'
INTO TABLE BOOK
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Book_id,Title);


LOAD DATA INFILE 'E:/DB design/Project/book_copies.csv'
INTO TABLE BOOK_COPIES
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Book_id,Branch_id,No_of_copies);


LOAD DATA INFILE 'E:/DB design/Project/Book_author.csv'
INTO TABLE BOOK_AUTHORS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Book_id,Author_Name);


LOAD DATA INFILE 'E:/DB design/Project/borrowers.csv'
INTO TABLE BORROWER
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(card_no,Fname,Lname,Address,Phone);


LOAD DATA INFILE 'E:/DB design/Project/library_branch.csv'
INTO TABLE LIBRARY_BRANCH
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Branch_id,Branch_name,Address);	

ALTER TABLE BOOK_AUTHORS ADD Type boolean;