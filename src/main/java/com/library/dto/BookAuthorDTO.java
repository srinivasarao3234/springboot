package com.library.dto;

/**
 * DTO to hold the result of the inner join query between Book and Author.
 * Used to display combined data from both entities.
 */
public class BookAuthorDTO {

    private Long bookId;
    private String bookTitle;
    private String isbn;
    private String genre;
    private Double price;
    private Integer publicationYear;
    private Long authorId;
    private String authorName;
    private String authorEmail;
    private String authorNationality;

    // Default Constructor
    public BookAuthorDTO() {}

    // Parameterized Constructor (used by JPQL constructor expression)
    public BookAuthorDTO(Long bookId, String bookTitle, String isbn, String genre,
                         Double price, Integer publicationYear,
                         Long authorId, String authorName, String authorEmail,
                         String authorNationality) {
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.isbn = isbn;
        this.genre = genre;
        this.price = price;
        this.publicationYear = publicationYear;
        this.authorId = authorId;
        this.authorName = authorName;
        this.authorEmail = authorEmail;
        this.authorNationality = authorNationality;
    }

    // Getters and Setters
    public Long getBookId() { return bookId; }
    public void setBookId(Long bookId) { this.bookId = bookId; }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public Integer getPublicationYear() { return publicationYear; }
    public void setPublicationYear(Integer publicationYear) { this.publicationYear = publicationYear; }

    public Long getAuthorId() { return authorId; }
    public void setAuthorId(Long authorId) { this.authorId = authorId; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getAuthorEmail() { return authorEmail; }
    public void setAuthorEmail(String authorEmail) { this.authorEmail = authorEmail; }

    public String getAuthorNationality() { return authorNationality; }
    public void setAuthorNationality(String authorNationality) { this.authorNationality = authorNationality; }
}
