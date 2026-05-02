package com.library.service;

import com.library.entity.Author;
import com.library.repository.AuthorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service class for Author entity.
 * Handles business logic and integrates with the repository layer.
 */
@Service
public class AuthorService {

    @Autowired
    private AuthorRepository authorRepository;

    /**
     * Get all authors from the database.
     * @return list of all authors
     */
    public List<Author> getAllAuthors() {
        return authorRepository.findAll();
    }

    /**
     * Get an author by ID.
     * @param id the author ID
     * @return Optional containing the author if found
     */
    public Optional<Author> getAuthorById(Long id) {
        return authorRepository.findById(id);
    }

    /**
     * Save a new author to the database.
     * Handles DataIntegrityViolationException for duplicate email.
     * @param author the author to save
     * @return the saved author
     * @throws DataIntegrityViolationException if email already exists
     */
    public Author saveAuthor(Author author) throws DataIntegrityViolationException {
        return authorRepository.save(author);
    }

    /**
     * Update an existing author.
     * @param id the author ID to update
     * @param updatedAuthor the updated author data
     * @return the updated author
     * @throws RuntimeException if author not found
     * @throws DataIntegrityViolationException if updated email conflicts
     */
    public Author updateAuthor(Long id, Author updatedAuthor) throws DataIntegrityViolationException {
        Author existingAuthor = authorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Author not found with id: " + id));

        existingAuthor.setName(updatedAuthor.getName());
        existingAuthor.setEmail(updatedAuthor.getEmail());
        existingAuthor.setNationality(updatedAuthor.getNationality());
        existingAuthor.setBio(updatedAuthor.getBio());

        return authorRepository.save(existingAuthor);
    }

    /**
     * Check if an author exists by ID.
     * @param id the author ID
     * @return true if exists
     */
    public boolean existsById(Long id) {
        return authorRepository.existsById(id);
    }

    /**
     * Get total count of authors.
     * @return count of authors
     */
    public long count() {
        return authorRepository.count();
    }
}
