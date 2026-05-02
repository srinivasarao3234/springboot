<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books - Library Management System</title>
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
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
                <li><a href="${pageContext.request.contextPath}/books" class="active">Books</a></li>
                <li><a href="${pageContext.request.contextPath}/books/with-authors">Join View</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>&#128214; Books</h1>
                <span class="subtitle">Browse and manage the book collection</span>
            </div>
            <div style="display: flex; gap: 1rem; align-items: center;">
                <span class="stat-badge">Total: ${totalBooks}</span>
                <a href="${pageContext.request.contextPath}/books/add" class="btn btn-primary">
                    &#10010; Add Book
                </a>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                &#10004; ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                &#10060; ${errorMessage}
            </div>
        </c:if>

        <!-- Books Table -->
        <c:choose>
            <c:when test="${not empty books}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>ISBN</th>
                                <th>Genre</th>
                                <th>Price</th>
                                <th>Year</th>
                                <th>Author</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>${book.id}</td>
                                    <td><strong>${book.title}</strong></td>
                                    <td><code>${book.isbn}</code></td>
                                    <td>
                                        <span class="badge
                                            <c:if test="${book.genre == 'Fantasy'}">fantasy</c:if>
                                            <c:if test="${book.genre == 'Romance'}">romance</c:if>
                                            <c:if test="${book.genre == 'Mystery'}">mystery</c:if>
                                            <c:if test="${book.genre == 'Adventure'}">adventure</c:if>
                                        ">${book.genre}</span>
                                    </td>
                                    <td><span class="price">$${book.price}</span></td>
                                    <td>${book.publicationYear}</td>
                                    <td>${book.author.name}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/books/edit/${book.id}"
                                           class="btn btn-warning btn-sm">
                                            &#9998; Edit
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">&#128214;</div>
                    <h3>No books found</h3>
                    <p>Get started by adding your first book.</p>
                    <a href="${pageContext.request.contextPath}/books/add" class="btn btn-primary" style="margin-top: 1rem;">
                        &#10010; Add Book
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Library Management System &mdash; Built with Spring Boot, JPA, and JSP</p>
    </footer>
</body>
</html>
