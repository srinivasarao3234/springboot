package com.library.repository;

import com.library.entity.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for Author entity.
 * Extends JpaRepository for standard CRUD operations.
 */
@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {

    /**
     * Find an author by email address.
     * Used for checking duplicate emails before save.
     */
    Author findByEmail(String email);

    /**
     * Check if an author exists by email.
     */
    boolean existsByEmail(String email);
}
