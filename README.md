# Library Management System

A Spring Boot application for managing Books and Authors, featuring Create, Read, and Update operations with JPA, JSP views, and comprehensive unit testing.

## Tech Stack

- **Java 21** + **Spring Boot 3.2.5**
- **Spring Data JPA** (Hibernate) for ORM
- **H2 Database** (In-Memory) for persistence
- **JSP** + **JSTL** for the view layer
- **JUnit 5** + **Mockito** for testing

## Entities

### Author (One)
- `id`, `name`, `email` (unique), `nationality`, `bio`
- `@OneToMany` → Books

### Book (Many)
- `id`, `title`, `isbn` (unique), `genre`, `price`, `publicationYear`
- `@ManyToOne` → Author

## Features

- **Create**: Add new authors and books via web forms
- **Read**: View all entities, Inner Join view (Books with Authors)
- **Update**: Edit existing author/book records
- **Validation**: Server-side validation with error messages
- **Exception Handling**: DataIntegrityViolationException handling
- **Custom Query**: JPQL INNER JOIN returning BookAuthorDTO

## Project Structure

```
src/
├── main/
│   ├── java/com/library/
│   │   ├── LibraryManagementApplication.java
│   │   ├── controller/
│   │   │   ├── HomeController.java
│   │   │   ├── AuthorController.java
│   │   │   └── BookController.java
│   │   ├── dto/
│   │   │   └── BookAuthorDTO.java
│   │   ├── entity/
│   │   │   ├── Author.java
│   │   │   └── Book.java
│   │   ├── repository/
│   │   │   ├── AuthorRepository.java
│   │   │   └── BookRepository.java
│   │   └── service/
│   │       ├── AuthorService.java
│   │       └── BookService.java
│   ├── resources/
│   │   ├── application.properties
│   │   └── data.sql
│   └── webapp/
│       ├── css/style.css
│       └── WEB-INF/jsp/
│           ├── home.jsp
│           ├── author-list.jsp
│           ├── author-form.jsp
│           ├── book-list.jsp
│           ├── book-form.jsp
│           └── book-author-list.jsp
└── test/java/com/library/
    ├── LibraryManagementApplicationTests.java
    ├── repository/RepositoryTests.java
    └── service/ServiceTests.java
```

## How to Run

1. Ensure Java 21 is installed
2. Run: `mvn spring-boot:run`
3. Open: http://localhost:8080
4. H2 Console: http://localhost:8080/h2-console

## Running Tests

```bash
mvn test
```
