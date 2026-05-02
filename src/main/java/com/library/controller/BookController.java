package com.library.controller;

import com.library.entity.Author;
import com.library.entity.Book;
import com.library.service.AuthorService;
import com.library.service.BookService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * Spring MVC Controller for handling Book-related HTTP requests.
 * Manages Create, Read, and Update operations for Books.
 * Also handles the INNER JOIN view between Books and Authors.
 */
@Controller
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @Autowired
    private AuthorService authorService;

    /**
     * READ: Display list of all books.
     * Fetches data from service layer and binds it to the JSP view.
     */
    @GetMapping
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.getAllBooks());
        model.addAttribute("totalBooks", bookService.count());
        return "book-list";
    }

    /**
     * CREATE: Show the form to add a new book.
     * Populates the author dropdown from the service layer.
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("authors", authorService.getAllAuthors());
        model.addAttribute("isEdit", false);
        return "book-form";
    }

    /**
     * CREATE: Handle form submission to save a new book.
     * Includes validation and exception handling for integrity violations.
     */
    @PostMapping("/save")
    public String saveBook(@Valid @ModelAttribute("book") Book book,
                           BindingResult bindingResult,
                           Model model,
                           RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("authors", authorService.getAllAuthors());
            model.addAttribute("isEdit", book.getId() != null);
            return "book-form";
        }

        try {
            if (book.getId() != null) {
                bookService.updateBook(book.getId(), book);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Book '" + book.getTitle() + "' updated successfully!");
            } else {
                bookService.saveBook(book);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Book '" + book.getTitle() + "' added successfully!");
            }
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("errorMessage",
                    "Data integrity violation: The ISBN '" + book.getIsbn() + "' may already exist.");
            model.addAttribute("authors", authorService.getAllAuthors());
            model.addAttribute("isEdit", book.getId() != null);
            return "book-form";
        }

        return "redirect:/books";
    }

    /**
     * UPDATE: Show the form pre-filled with existing book data.
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model,
                               RedirectAttributes redirectAttributes) {
        return bookService.getBookById(id)
                .map(book -> {
                    model.addAttribute("book", book);
                    model.addAttribute("authors", authorService.getAllAuthors());
                    model.addAttribute("isEdit", true);
                    return "book-form";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("errorMessage",
                            "Book not found with ID: " + id);
                    return "redirect:/books";
                });
    }

    /**
     * READ: Display INNER JOIN results — Books with Authors combined.
     * Uses the custom repository query through the service layer.
     */
    @GetMapping("/with-authors")
    public String listBooksWithAuthors(Model model) {
        model.addAttribute("bookAuthors", bookService.getAllBooksWithAuthors());
        return "book-author-list";
    }
}
