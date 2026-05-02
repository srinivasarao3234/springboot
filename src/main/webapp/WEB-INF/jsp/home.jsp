<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="nav-brand">
                <span class="brand-icon">&#128218;</span>
                LibraryMS
            </a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/" class="active">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
                <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
                <li><a href="${pageContext.request.contextPath}/books/with-authors">Join View</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <!-- Hero Section -->
        <div class="hero">
            <h1>Library Management System</h1>
            <p>A comprehensive Spring Boot application for managing books and authors with full CRUD operations, JPA relationships, and custom queries.</p>
            <div class="hero-actions">
                <a href="${pageContext.request.contextPath}/authors" class="btn btn-primary">&#128100; Manage Authors</a>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">&#128214; Manage Books</a>
                <a href="${pageContext.request.contextPath}/books/with-authors" class="btn btn-success">&#128279; View Join Data</a>
            </div>
        </div>

        <!-- Feature Cards -->
        <div class="card-grid">
            <div class="card animate-in">
                <div class="card-icon authors">&#128100;</div>
                <h3>Manage Authors</h3>
                <p>Add, view, and update author information including name, email, nationality, and biography.</p>
                <a href="${pageContext.request.contextPath}/authors" class="btn btn-primary btn-sm">View Authors &#8594;</a>
            </div>

            <div class="card animate-in">
                <div class="card-icon books">&#128214;</div>
                <h3>Manage Books</h3>
                <p>Create, browse, and edit book records with title, ISBN, genre, price, and author assignment.</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary btn-sm">View Books &#8594;</a>
            </div>

            <div class="card animate-in">
                <div class="card-icon join">&#128279;</div>
                <h3>Inner Join View</h3>
                <p>View the custom JPQL INNER JOIN query results combining book and author data in a single view.</p>
                <a href="${pageContext.request.contextPath}/books/with-authors" class="btn btn-primary btn-sm">View Join Data &#8594;</a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Library Management System &mdash; Built with Spring Boot, JPA, and JSP</p>
    </footer>
</body>
</html>
