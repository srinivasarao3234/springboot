package com.library.service;

import com.library.dto.BookAuthorDTO;
import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service class for Book entity.
 * Handles business logic and integrates with the repository layer.
 */
@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    /**
     * Get all books from the database.
     * @return list of all books
     */
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    /**
     * Get a book by ID.
     * @param id the book ID
     * @return Optional containing the book if found
     */
    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }

    /**
     * Save a new book to the database.
     * Handles DataIntegrityViolationException for duplicate ISBN.
     * @param book the book to save
     * @return the saved book
     * @throws DataIntegrityViolationException if ISBN already exists
     */
    public Book saveBook(Book book) throws DataIntegrityViolationException {
        return bookRepository.save(book);
    }

    /**
     * Update an existing book.
     * @param id the book ID to update
     * @param updatedBook the updated book data
     * @return the updated book
     * @throws RuntimeException if book not found
     * @throws DataIntegrityViolationException if updated ISBN conflicts
     */
    public Book updateBook(Long id, Book updatedBook) throws DataIntegrityViolationException {
        Book existingBook = bookRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Book not found with id: " + id));

        existingBook.setTitle(updatedBook.getTitle());
        existingBook.setIsbn(updatedBook.getIsbn());
        existingBook.setGenre(updatedBook.getGenre());
        existingBook.setPrice(updatedBook.getPrice());
        existingBook.setPublicationYear(updatedBook.getPublicationYear());
        existingBook.setAuthor(updatedBook.getAuthor());

        return bookRepository.save(existingBook);
    }

    /**
     * Get all books with their author details using the INNER JOIN query.
     * This calls the custom repository method.
     * @return list of BookAuthorDTO objects
     */
    public List<BookAuthorDTO> getAllBooksWithAuthors() {
        return bookRepository.findAllBooksWithAuthors();
    }

    /**
     * Get books by author ID.
     * @param authorId the author ID
     * @return list of books by that author
     */
    public List<Book> getBooksByAuthorId(Long authorId) {
        return bookRepository.findByAuthorId(authorId);
    }

    /**
     * Get total count of books.
     * @return count of books
     */
    public long count() {
        return bookRepository.count();
    }
}
