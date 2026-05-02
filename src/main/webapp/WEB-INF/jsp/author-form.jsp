<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Add'} Author - Library Management System</title>
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
        <div class="form-container">
            <h2>${isEdit ? '&#9998; Edit Author' : '&#10010; Add New Author'}</h2>
            <p class="form-subtitle">
                ${isEdit ? 'Update the author details below.' : 'Fill in the details to register a new author.'}
            </p>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    &#10060; ${errorMessage}
                </div>
            </c:if>

            <!-- Author Form -->
            <form:form action="${pageContext.request.contextPath}/authors/save"
                       method="POST" modelAttribute="author">

                <!-- Hidden ID field for edit mode -->
                <c:if test="${isEdit}">
                    <form:hidden path="id"/>
                </c:if>

                <div class="form-group">
                    <label for="name">Author Name <span class="required">*</span></label>
                    <form:input path="name" id="name" cssClass="form-control"
                                placeholder="Enter author name"/>
                    <form:errors path="name" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="email">Email Address <span class="required">*</span></label>
                    <form:input path="email" id="email" type="email" cssClass="form-control"
                                placeholder="Enter email address"/>
                    <form:errors path="email" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="nationality">Nationality</label>
                    <form:input path="nationality" id="nationality" cssClass="form-control"
                                placeholder="Enter nationality"/>
                    <form:errors path="nationality" cssClass="error-text"/>
                </div>

                <div class="form-group">
                    <label for="bio">Biography</label>
                    <form:textarea path="bio" id="bio" cssClass="form-control"
                                   placeholder="Enter a short biography" rows="4"/>
                    <form:errors path="bio" cssClass="error-text"/>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">
                        ${isEdit ? '&#128190; Update Author' : '&#10010; Add Author'}
                    </button>
                    <a href="${pageContext.request.contextPath}/authors" class="btn btn-secondary">
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
