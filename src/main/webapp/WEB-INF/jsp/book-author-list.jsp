<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books with Authors (Inner Join) - Library Management System</title>
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
                <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
                <li><a href="${pageContext.request.contextPath}/books/with-authors" class="active">Join View</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>&#128279; Books &amp; Authors (Inner Join)</h1>
                <span class="subtitle">Custom JPQL INNER JOIN query result combining both entities</span>
            </div>
            <span class="stat-badge">
                &#128202; ${bookAuthors.size()} Records
            </span>
        </div>

        <!-- Info Alert -->
        <div class="alert alert-success">
            &#128161; This view uses a custom <strong>@Query</strong> with <strong>INNER JOIN</strong> between the
            <code>Book</code> and <code>Author</code> entities, returning <code>BookAuthorDTO</code> objects.
        </div>

        <!-- Join Results Table -->
        <c:choose>
            <c:when test="${not empty bookAuthors}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Book ID</th>
                                <th>Book Title</th>
                                <th>ISBN</th>
                                <th>Genre</th>
                                <th>Price</th>
                                <th>Year</th>
                                <th>Author ID</th>
                                <th>Author Name</th>
                                <th>Author Email</th>
                                <th>Nationality</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ba" items="${bookAuthors}">
                                <tr>
                                    <td>${ba.bookId}</td>
                                    <td><strong>${ba.bookTitle}</strong></td>
                                    <td><code>${ba.isbn}</code></td>
                                    <td>
                                        <span class="badge
                                            <c:if test="${ba.genre == 'Fantasy'}">fantasy</c:if>
                                            <c:if test="${ba.genre == 'Romance'}">romance</c:if>
                                            <c:if test="${ba.genre == 'Mystery'}">mystery</c:if>
                                            <c:if test="${ba.genre == 'Adventure'}">adventure</c:if>
                                        ">${ba.genre}</span>
                                    </td>
                                    <td><span class="price">$${ba.price}</span></td>
                                    <td>${ba.publicationYear}</td>
                                    <td>${ba.authorId}</td>
                                    <td><strong>${ba.authorName}</strong></td>
                                    <td>${ba.authorEmail}</td>
                                    <td>
                                        <span class="badge">${ba.authorNationality}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">&#128279;</div>
                    <h3>No join results found</h3>
                    <p>Add books with assigned authors to see the join results.</p>
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
