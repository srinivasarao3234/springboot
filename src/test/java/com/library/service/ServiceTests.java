package com.library.service;

import com.library.dto.BookAuthorDTO;
import com.library.entity.Author;
import com.library.entity.Book;
import com.library.repository.AuthorRepository;
import com.library.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for the Service layer using Mockito.
 * Mocks the Repository layer to isolate service logic testing.
 */
@ExtendWith(MockitoExtension.class)
class ServiceTests {

    // ===================== AUTHOR SERVICE TESTS =====================

    @Mock
    private AuthorRepository authorRepository;

    @InjectMocks
    private AuthorService authorService;

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private BookService bookService;

    private Author author1;
    private Author author2;
    private Book book1;
    private Book book2;

    @BeforeEach
    void setUp() {
        author1 = new Author("John Doe", "john@example.com", "American", "A great writer.");
        author1.setId(1L);

        author2 = new Author("Jane Smith", "jane@example.com", "British", "An award-winning author.");
        author2.setId(2L);

        book1 = new Book("Book One", "978-1-11111-111-1", "Fiction", 19.99, 2023, author1);
        book1.setId(1L);

        book2 = new Book("Book Two", "978-2-22222-222-2", "Sci-Fi", 24.99, 2024, author2);
        book2.setId(2L);
    }

    // ---- AuthorService Tests ----

    @Test
    @DisplayName("AuthorService: Get all authors")
    void testGetAllAuthors() {
        when(authorRepository.findAll()).thenReturn(Arrays.asList(author1, author2));

        List<Author> authors = authorService.getAllAuthors();

        assertThat(authors).hasSize(2);
        assertThat(authors.get(0).getName()).isEqualTo("John Doe");
        verify(authorRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("AuthorService: Get author by ID - found")
    void testGetAuthorByIdFound() {
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author1));

        Optional<Author> found = authorService.getAuthorById(1L);

        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("John Doe");
    }

    @Test
    @DisplayName("AuthorService: Get author by ID - not found")
    void testGetAuthorByIdNotFound() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        Optional<Author> found = authorService.getAuthorById(99L);

        assertThat(found).isEmpty();
    }

    @Test
    @DisplayName("AuthorService: Save a new author successfully")
    void testSaveAuthor() {
        when(authorRepository.save(any(Author.class))).thenReturn(author1);

        Author saved = authorService.saveAuthor(author1);

        assertThat(saved).isNotNull();
        assertThat(saved.getName()).isEqualTo("John Doe");
        verify(authorRepository, times(1)).save(author1);
    }

    @Test
    @DisplayName("AuthorService: Save author throws DataIntegrityViolationException")
    void testSaveAuthorIntegrityViolation() {
        when(authorRepository.save(any(Author.class)))
                .thenThrow(new DataIntegrityViolationException("Duplicate email"));

        assertThatThrownBy(() -> authorService.saveAuthor(author1))
                .isInstanceOf(DataIntegrityViolationException.class);
    }

    @Test
    @DisplayName("AuthorService: Update an existing author")
    void testUpdateAuthor() {
        Author updatedData = new Author("Updated Name", "updated@example.com", "Canadian", "Updated bio.");
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author1));
        when(authorRepository.save(any(Author.class))).thenReturn(author1);

        Author updated = authorService.updateAuthor(1L, updatedData);

        assertThat(updated).isNotNull();
        verify(authorRepository).findById(1L);
        verify(authorRepository).save(any(Author.class));
    }

    @Test
    @DisplayName("AuthorService: Update non-existent author throws RuntimeException")
    void testUpdateAuthorNotFound() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> authorService.updateAuthor(99L, author1))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Author not found");
    }

    @Test
    @DisplayName("AuthorService: Count authors")
    void testCountAuthors() {
        when(authorRepository.count()).thenReturn(10L);

        long count = authorService.count();

        assertThat(count).isEqualTo(10);
    }

    // ---- BookService Tests ----

    @Test
    @DisplayName("BookService: Get all books")
    void testGetAllBooks() {
        when(bookRepository.findAll()).thenReturn(Arrays.asList(book1, book2));

        List<Book> books = bookService.getAllBooks();

        assertThat(books).hasSize(2);
        verify(bookRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("BookService: Get book by ID")
    void testGetBookById() {
        when(bookRepository.findById(1L)).thenReturn(Optional.of(book1));

        Optional<Book> found = bookService.getBookById(1L);

        assertThat(found).isPresent();
        assertThat(found.get().getTitle()).isEqualTo("Book One");
    }

    @Test
    @DisplayName("BookService: Save a new book")
    void testSaveBook() {
        when(bookRepository.save(any(Book.class))).thenReturn(book1);

        Book saved = bookService.saveBook(book1);

        assertThat(saved).isNotNull();
        assertThat(saved.getTitle()).isEqualTo("Book One");
        verify(bookRepository, times(1)).save(book1);
    }

    @Test
    @DisplayName("BookService: Save book throws DataIntegrityViolationException")
    void testSaveBookIntegrityViolation() {
        when(bookRepository.save(any(Book.class)))
                .thenThrow(new DataIntegrityViolationException("Duplicate ISBN"));

        assertThatThrownBy(() -> bookService.saveBook(book1))
                .isInstanceOf(DataIntegrityViolationException.class);
    }

    @Test
    @DisplayName("BookService: Update an existing book")
    void testUpdateBook() {
        Book updatedData = new Book("Updated Title", "978-3-33333-333-3", "Drama", 34.99, 2025, author2);
        when(bookRepository.findById(1L)).thenReturn(Optional.of(book1));
        when(bookRepository.save(any(Book.class))).thenReturn(book1);

        Book updated = bookService.updateBook(1L, updatedData);

        assertThat(updated).isNotNull();
        verify(bookRepository).findById(1L);
        verify(bookRepository).save(any(Book.class));
    }

    @Test
    @DisplayName("BookService: Get all books with authors (INNER JOIN)")
    void testGetAllBooksWithAuthors() {
        BookAuthorDTO dto1 = new BookAuthorDTO(1L, "Book One", "978-1-11111-111-1", "Fiction",
                19.99, 2023, 1L, "John Doe", "john@example.com", "American");
        BookAuthorDTO dto2 = new BookAuthorDTO(2L, "Book Two", "978-2-22222-222-2", "Sci-Fi",
                24.99, 2024, 2L, "Jane Smith", "jane@example.com", "British");

        when(bookRepository.findAllBooksWithAuthors()).thenReturn(Arrays.asList(dto1, dto2));

        List<BookAuthorDTO> results = bookService.getAllBooksWithAuthors();

        assertThat(results).hasSize(2);
        assertThat(results.get(0).getBookTitle()).isEqualTo("Book One");
        assertThat(results.get(0).getAuthorName()).isEqualTo("John Doe");
        verify(bookRepository, times(1)).findAllBooksWithAuthors();
    }

    @Test
    @DisplayName("BookService: Get books by author ID")
    void testGetBooksByAuthorId() {
        when(bookRepository.findByAuthorId(1L)).thenReturn(List.of(book1));

        List<Book> books = bookService.getBooksByAuthorId(1L);

        assertThat(books).hasSize(1);
        assertThat(books.get(0).getAuthor().getId()).isEqualTo(1L);
    }
}
