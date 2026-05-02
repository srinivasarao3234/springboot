<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Add'} Book - Library Management System</title>
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
        <div class="form-container">
            <h2>${isEdit ? '&#9998; Edit Book' : '&#10010; Add New Book'}</h2>
            <p class="form-subtitle">
                ${isEdit ? 'Update the book details below.' : 'Fill in the details to add a new book to the collection.'}
            </p>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    &#10060; ${errorMessage}
                </div>
            </c:if>

            <!-- Book Form -->
            <form:form action="${pageContext.request.contextPath}/books/save"
                       method="POST" modelAttribute="book">

                <!-- Hidden ID field for edit mode -->
                <c:if test="${isEdit}">
                    <form:hidden path="id"/>
                </c:if>

                <div class="form-group">
                    <label for="title">Book Title <span class="required">*</span></label>
                    <form:input path="title" id="title" cssClass="form-control"
                                placeholder="Enter book title"/>
                    <form:errors path="title" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="isbn">ISBN <span class="required">*</span></label>
                    <form:input path="isbn" id="isbn" cssClass="form-control"
                                placeholder="Enter ISBN (e.g., 978-0-12345-678-9)"/>
                    <form:errors path="isbn" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="genre">Genre</label>
                    <form:input path="genre" id="genre" cssClass="form-control"
                                placeholder="Enter genre (e.g., Fantasy, Mystery)"/>
                    <form:errors path="genre" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="price">Price ($) <span class="required">*</span></label>
                    <form:input path="price" id="price" type="number" step="0.01" cssClass="form-control"
                                placeholder="Enter price"/>
                    <form:errors path="price" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="publicationYear">Publication Year</label>
                    <form:input path="publicationYear" id="publicationYear" type="number"
                                cssClass="form-control" placeholder="Enter publication year"/>
                    <form:errors path="publicationYear" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="author.id">Author <span class="required">*</span></label>
                    <form:select path="author.id" id="author.id" cssClass="form-control">
                        <form:option value="" label="-- Select an Author --"/>
                        <c:forEach var="authorItem" items="${authors}">
                            <form:option value="${authorItem.id}" label="${authorItem.name}"/>
                        </c:forEach>
                    </form:select>
                    <form:errors path="author" cssClass="error-text"/>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">
                        ${isEdit ? '&#128190; Update Book' : '&#10010; Add Book'}
                    </button>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">
                        &#8592; Cancel
                    </a>
                </div>
            </form:form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Library Management System &mdash; Built with Spring Boot, JPA, and JSP</p>
    </footer>
</body>
</html>
