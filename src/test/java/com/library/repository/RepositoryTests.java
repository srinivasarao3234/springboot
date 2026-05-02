package com.library.repository;

import com.library.dto.BookAuthorDTO;
import com.library.entity.Author;
import com.library.entity.Book;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Unit tests for the Repository layer.
 * Uses @DataJpaTest for lightweight JPA-only testing with an in-memory database.
 */
@DataJpaTest
class RepositoryTests {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private AuthorRepository authorRepository;

    @Autowired
    private BookRepository bookRepository;

    private Author testAuthor;
    private Book testBook;

    @BeforeEach
    void setUp() {
        // Create and persist a test author
        testAuthor = new Author("Test Author", "test@example.com", "Indian", "A test author bio.");
        entityManager.persist(testAuthor);

        // Create and persist a test book linked to the author
        testBook = new Book("Test Book", "978-0-00000-000-0", "Fiction", 19.99, 2024, testAuthor);
        entityManager.persist(testBook);

        entityManager.flush();
    }

    // ===================== AUTHOR REPOSITORY TESTS =====================

    @Test
    @DisplayName("AuthorRepository: Find all authors")
    void testFindAllAuthors() {
        List<Author> authors = authorRepository.findAll();
        // Includes authors from data.sql + our test author
        assertThat(authors).isNotEmpty();
    }

    @Test
    @DisplayName("AuthorRepository: Find author by ID")
    void testFindAuthorById() {
        Optional<Author> found = authorRepository.findById(testAuthor.getId());
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("Test Author");
    }

    @Test
    @DisplayName("AuthorRepository: Save a new author")
    void testSaveAuthor() {
        Author newAuthor = new Author("New Author", "new@example.com", "American", "New bio");
        Author saved = authorRepository.save(newAuthor);

        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getName()).isEqualTo("New Author");
        assertThat(saved.getEmail()).isEqualTo("new@example.com");
    }

    @Test
    @DisplayName("AuthorRepository: Find author by email")
    void testFindByEmail() {
        Author found = authorRepository.findByEmail("test@example.com");
        assertThat(found).isNotNull();
        assertThat(found.getName()).isEqualTo("Test Author");
    }

    @Test
    @DisplayName("AuthorRepository: Check exists by email")
    void testExistsByEmail() {
        boolean exists = authorRepository.existsByEmail("test@example.com");
        assertThat(exists).isTrue();

        boolean notExists = authorRepository.existsByEmail("nonexistent@example.com");
        assertThat(notExists).isFalse();
    }

    @Test
    @DisplayName("AuthorRepository: Update an existing author")
    void testUpdateAuthor() {
        testAuthor.setName("Updated Author");
        testAuthor.setNationality("British");
        Author updated = authorRepository.save(testAuthor);

        assertThat(updated.getName()).isEqualTo("Updated Author");
        assertThat(updated.getNationality()).isEqualTo("British");
    }

    @Test
    @DisplayName("AuthorRepository: Count authors")
    void testCountAuthors() {
        long count = authorRepository.count();
        assertThat(count).isGreaterThan(0);
    }

    // ===================== BOOK REPOSITORY TESTS =====================

    @Test
    @DisplayName("BookRepository: Find all books")
    void testFindAllBooks() {
        List<Book> books = bookRepository.findAll();
        assertThat(books).isNotEmpty();
    }

    @Test
    @DisplayName("BookRepository: Find book by ID")
    void testFindBookById() {
        Optional<Book> found = bookRepository.findById(testBook.getId());
        assertThat(found).isPresent();
        assertThat(found.get().getTitle()).isEqualTo("Test Book");
        assertThat(found.get().getIsbn()).isEqualTo("978-0-00000-000-0");
    }

    @Test
    @DisplayName("BookRepository: Save a new book")
    void testSaveBook() {
        Book newBook = new Book("New Book", "978-1-11111-111-1", "Sci-Fi", 29.99, 2025, testAuthor);
        Book saved = bookRepository.save(newBook);

        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getTitle()).isEqualTo("New Book");
        assertThat(saved.getAuthor().getName()).isEqualTo("Test Author");
    }

    @Test
    @DisplayName("BookRepository: Find books by author ID")
    void testFindByAuthorId() {
        List<Book> books = bookRepository.findByAuthorId(testAuthor.getId());
        assertThat(books).isNotEmpty();
        assertThat(books.get(0).getAuthor().getId()).isEqualTo(testAuthor.getId());
    }

    @Test
    @DisplayName("BookRepository: Custom INNER JOIN query - findAllBooksWithAuthors")
    void testFindAllBooksWithAuthors() {
        List<BookAuthorDTO> results = bookRepository.findAllBooksWithAuthors();

        assertThat(results).isNotEmpty();
        // Verify DTO fields are populated
        BookAuthorDTO firstResult = results.get(0);
        assertThat(firstResult.getBookId()).isNotNull();
        assertThat(firstResult.getBookTitle()).isNotBlank();
        assertThat(firstResult.getAuthorId()).isNotNull();
        assertThat(firstResult.getAuthorName()).isNotBlank();
    }

    @Test
    @DisplayName("BookRepository: Check exists by ISBN")
    void testExistsByIsbn() {
        boolean exists = bookRepository.existsByIsbn("978-0-00000-000-0");
        assertThat(exists).isTrue();

        boolean notExists = bookRepository.existsByIsbn("000-0-00000-000-0");
        assertThat(notExists).isFalse();
    }
}
