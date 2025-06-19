<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2 class="mb-4">Add New Book</h2>

    <form action="AddBookServlet" method="post">
        <div class="mb-3">
            <label for="bookTitle" class="form-label">Title:</label>
            <input type="text" name="bookTitle" id="bookTitle" class="form-control" placeholder="Enter book title" required />
        </div>

        <div class="mb-3">
            <label for="bookAuthor" class="form-label">Author:</label>
            <input type="text" name="bookAuthor" id="bookAuthor" class="form-control" placeholder="Enter author name" required />
        </div>

        <div class="mb-3">
            <label for="datePublished" class="form-label">Date Published:</label>
            <input type="date" name="datePublished" id="datePublished" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="synopsis" class="form-label">Synopsis:</label>
            <textarea name="synopsis" id="synopsis" class="form-control" rows="4" placeholder="Enter a brief synopsis..." required></textarea>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">Save Book</button>
            <a href="BookCollection.jsp" class="btn btn-secondary">Back</a>
            <a href="book-listing.jsp" class="btn btn-warning">Edit Book</a>
        </div>
    </form>
</body>
</html>
