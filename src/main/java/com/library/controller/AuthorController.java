package com.library.controller;

import com.library.entity.Author;
import com.library.service.AuthorService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Spring MVC Controller for handling Author-related HTTP requests.
 * Manages Create, Read, and Update operations for Authors.
 */
@Controller
@RequestMapping("/authors")
public class AuthorController {

    @Autowired
    private AuthorService authorService;

    /**
     * READ: Display list of all authors.
     * Fetches data from service layer and binds it to the JSP view.
     */
    @GetMapping
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.getAllAuthors());
        model.addAttribute("totalAuthors", authorService.count());
        return "author-list";
    }

    /**
     * CREATE: Show the form to add a new author.
     * Binds an empty Author object to the form.
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("author", new Author());
        model.addAttribute("isEdit", false);
        return "author-form";
    }

    /**
     * CREATE: Handle form submission to save a new author.
     * Includes validation and exception handling for integrity violations.
     */
    @PostMapping("/save")
    public String saveAuthor(@Valid @ModelAttribute("author") Author author,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("isEdit", author.getId() != null);
            return "author-form";
        }

        try {
            if (author.getId() != null) {
                authorService.updateAuthor(author.getId(), author);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Author '" + author.getName() + "' updated successfully!");
            } else {
                authorService.saveAuthor(author);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Author '" + author.getName() + "' added successfully!");
            }
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("errorMessage",
                    "Data integrity violation: The email '" + author.getEmail() + "' may already exist.");
            model.addAttribute("isEdit", author.getId() != null);
            return "author-form";
        }

        return "redirect:/authors";
    }

    /**
     * UPDATE: Show the form pre-filled with existing author data.
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model,
                               RedirectAttributes redirectAttributes) {
        return authorService.getAuthorById(id)
                .map(author -> {
                    model.addAttribute("author", author);
                    model.addAttribute("isEdit", true);
                    return "author-form";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("errorMessage",
                            "Author not found with ID: " + id);
                    return "redirect:/authors";
                });
    }
}
