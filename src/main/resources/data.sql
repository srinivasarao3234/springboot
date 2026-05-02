-- ============================================================
-- Sample Data: 10 Authors and 10 Books
-- This file is auto-executed by Spring Boot on startup.
-- ============================================================

-- Insert 10 Authors
INSERT INTO authors (name, email, nationality, bio) VALUES
('J.K. Rowling', 'jk.rowling@books.com', 'British', 'Best known for the Harry Potter fantasy series.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('George Orwell', 'george.orwell@books.com', 'British', 'Famous for his dystopian novels.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Harper Lee', 'harper.lee@books.com', 'American', 'Author of the Pulitzer Prize-winning novel.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('F. Scott Fitzgerald', 'fitzgerald@books.com', 'American', 'A key figure of the Jazz Age literary movement.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Jane Austen', 'jane.austen@books.com', 'British', 'Known for her social commentary in romantic fiction.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Mark Twain', 'mark.twain@books.com', 'American', 'The father of American literature.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Leo Tolstoy', 'leo.tolstoy@books.com', 'Russian', 'One of the greatest authors of all time.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Gabriel Garcia Marquez', 'ggmarquez@books.com', 'Colombian', 'Nobel Prize-winning author of magical realism.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Agatha Christie', 'agatha.christie@books.com', 'British', 'Best-selling fiction writer of all time.');
INSERT INTO authors (name, email, nationality, bio) VALUES
('Ernest Hemingway', 'hemingway@books.com', 'American', 'Known for his economical and understated style.');

-- Insert 10 Books (each linked to an author via author_id)
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('Harry Potter and the Sorcerer''s Stone', '978-0-7475-3269-9', 'Fantasy', 24.99, 1997, 1);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('1984', '978-0-452-28423-4', 'Dystopian', 15.99, 1949, 2);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('To Kill a Mockingbird', '978-0-06-112008-4', 'Classic Fiction', 18.99, 1960, 3);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('The Great Gatsby', '978-0-7432-7356-5', 'Classic Fiction', 14.99, 1925, 4);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('Pride and Prejudice', '978-0-19-953556-9', 'Romance', 12.99, 1813, 5);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('Adventures of Huckleberry Finn', '978-0-486-28061-5', 'Adventure', 11.99, 1884, 6);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('War and Peace', '978-0-19-923276-5', 'Historical Fiction', 22.99, 1869, 7);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('One Hundred Years of Solitude', '978-0-06-088328-7', 'Magical Realism', 19.99, 1967, 8);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('Murder on the Orient Express', '978-0-06-269366-2', 'Mystery', 16.99, 1934, 9);
INSERT INTO books (title, isbn, genre, price, publication_year, author_id) VALUES
('The Old Man and the Sea', '978-0-684-80122-3', 'Literary Fiction', 13.99, 1952, 10);
