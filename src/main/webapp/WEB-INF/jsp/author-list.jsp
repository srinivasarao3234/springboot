<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authors - Library Management System</title>
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
                <li><a href="${pageContext.request.contextPath}/authors" class="active">Authors</a></li>
                <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
                <li><a href="${pageContext.request.contextPath}/books/with-authors">Join View</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>&#128100; Authors</h1>
                <span class="subtitle">Manage all registered authors</span>
            </div>
            <div style="display: flex; gap: 1rem; align-items: center;">
                <span class="stat-badge">Total: ${totalAuthors}</span>
                <a href="${pageContext.request.contextPath}/authors/add" class="btn btn-primary">
                    &#10010; Add Author
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

        <!-- Authors Table -->
        <c:choose>
            <c:when test="${not empty authors}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Nationality</th>
                                <th>Bio</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="author" items="${authors}">
                                <tr>
                                    <td>${author.id}</td>
                                    <td><strong>${author.name}</strong></td>
                                    <td>${author.email}</td>
                                    <td>
                                        <span class="badge">${author.nationality}</span>
                                    </td>
                                    <td>${author.bio}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/authors/edit/${author.id}"
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
                    <div class="icon">&#128100;</div>
                    <h3>No authors found</h3>
                    <p>Get started by adding your first author.</p>
                    <a href="${pageContext.request.contextPath}/authors/add" class="btn btn-primary" style="margin-top: 1rem;">
                        &#10010; Add Author
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
