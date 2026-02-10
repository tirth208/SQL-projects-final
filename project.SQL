 CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);
[12:00 pm, 29/01/2026] TIRTH VIRANI: CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    author_id INT,
    category VARCHAR(50),
    isbn VARCHAR(20),
    published_date DATE,
    price DECIMAL(8,2),
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);
 CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    membership_date DATE
);
 CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    fine_amount DECIMAL(8,2),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
 INSERT INTO Authors (name, email)
VALUES ('A P J Abdul Kalam', 'kalam@gmail.com');

INSERT INTO Members (name, email, phone_number, membership_date)
VALUES ('Rahul Sharma', 'rahul@gmail.com', '9876543210', '2021-05-10');

INSERT INTO Books (title, author_id, category, isbn, published_date, price, available_copies)
VALUES ('Wings of Fire', 1, 'Science', 'ISBN001', '2016-01-01', 450, 5);
 UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = 1;
 DELETE FROM Members
WHERE member_id NOT IN (
    SELECT DISTINCT member_id
    FROM Transactions
    WHERE borrow_date >= CURDATE() - INTERVAL 1 YEAR
);
 SELECT * FROM Books WHERE available_copies > 0;
 SELECT * FROM Books
WHERE published_date > '2015-01-01';

SELECT * FROM Books
ORDER BY price DESC
LIMIT 5;

SELECT * FROM Members
WHERE membership_date < '2022-01-01';
 SELECT * FROM Books
WHERE category = 'Science' AND price < 500;

SELECT * FROM Books
WHERE available_copies = 0;

SELECT * FROM Members
WHERE membership_date > '2020-01-01'
OR member_id IN (
    SELECT member_id
    FROM Transactions
    GROUP BY member_id
    HAVING COUNT(book_id) > 3
);
 SELECT * FROM Books ORDER BY title ASC;

SELECT member_id, COUNT(book_id) AS total_books
FROM Transactions
GROUP BY member_id;

SELECT category, COUNT(*) AS total
FROM Books
GROUP BY category;
 SELECT category, COUNT(*) FROM Books GROUP BY category;

SELECT AVG(price) AS avg_price FROM Books;

SELECT book_id, COUNT(*) AS borrow_count
FROM Transactions
GROUP BY book_id
ORDER BY borrow_count DESC
LIMIT 1;

SELECT SUM(fine_amount) AS total_fine FROM Transactions;
 SELECT b.title, a.name
FROM Books b
INNER JOIN Authors a ON b.author_id = a.author_id;

SELECT m.name, t.book_id
FROM Members m
LEFT JOIN Transactions t ON m.member_id = t.member_id;

SELECT * FROM Books
WHERE book_id NOT IN (SELECT book_id FROM Transactions);

SELECT m.*
FROM Members m
LEFT JOIN Transactions t ON m.member_id = t.member_id
WHERE t.transaction_id IS NULL;
 SELECT * FROM Books
WHERE book_id IN (
    SELECT book_id
    FROM Transactions
    WHERE member_id IN (
        SELECT member_id
        FROM Members
        WHERE membership_date > '2022-01-01'
    )
);

SELECT * FROM Members
WHERE member_id NOT IN (
    SELECT DISTINCT member_id FROM Transactions
);
 SELECT YEAR(published_date) AS year, COUNT(*)
FROM Books
GROUP BY YEAR(published_date);

SELECT DATEDIFF(return_date, borrow_date) AS days_diff
FROM Transactions;

SELECT DATE_FORMAT(borrow_date, '%d-%m-%Y') FROM Transactions;
 UPDATE Books SET title = UPPER(title);

UPDATE Authors SET name = TRIM(name);

UPDATE Members
SET email = 'Not Provided'
WHERE email IS NULL;
 SELECT book_id,
COUNT(*) AS total_borrowed,
RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_no
FROM Transactions
GROUP BY book_id;

SELECT member_id,
COUNT(*) OVER (PARTITION BY member_id) AS total_books
FROM Transactions;
SELECT member_id,
CASE
    WHEN member_id IN (
        SELECT member_id
        FROM Transactions
        WHERE borrow_date >= CURDATE() - INTERVAL 6 MONTH
    ) THEN 'Active'
    ELSE 'Inactive'
END AS Membership_Status
FROM Members;
SELECT title,
CASE
    WHEN published_date > '2020-01-01' THEN 'New Arrival'
    WHEN published_date < '2000-01-01' THEN 'Classic'
    ELSE 'Regular'
END AS Book_Type
FROM Books;
 SELECT title,
CASE
    WHEN published_date > '2020-01-01' THEN 'New Arrival'
    WHEN published_date < '2000-01-01' THEN 'Classic'
    ELSE 'Regular'
END AS Book_Type
FROM Books; SELECT title,
CASE
    WHEN published_date > '2020-01-01' THEN 'New Arrival'
    WHEN published_date < '2000-01-01' THEN 'Classic'
    ELSE 'Regular'
END AS Book_Type
FROM Books;