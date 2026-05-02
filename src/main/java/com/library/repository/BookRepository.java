package com.library.repository;

import com.library.dto.BookAuthorDTO;
import com.library.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for Book entity.
 * Extends JpaRepository for standard CRUD operations.
 * Includes a custom JPQL query for INNER JOIN between Book and Author.
 */
@Repository
public interface BookRepository extends JpaRepository<Book, Long> {

    /**
     * Custom query method that performs an INNER JOIN between Book and Author.
     * Returns a list of BookAuthorDTO objects containing combined data.
     * Uses JPQL constructor expression to map results to DTO.
     */
    @Query("SELECT new com.library.dto.BookAuthorDTO(" +
           "b.id, b.title, b.isbn, b.genre, b.price, b.publicationYear, " +
           "a.id, a.name, a.email, a.nationality) " +
           "FROM Book b INNER JOIN b.author a " +
           "ORDER BY b.title")
    List<BookAuthorDTO> findAllBooksWithAuthors();

    /**
     * Find books by author ID.
     */
    List<Book> findByAuthorId(Long authorId);

    /**
     * Check if a book exists with the given ISBN.
     */
    boolean existsByIsbn(String isbn);
}
