<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Book Listing</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body class="container mt-5">
        <h2>List of Books</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Book Title</th>
                    <th>Book Author</th>
                    <th>Date Published</th>
                    <th>Synopsis</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Read DB config from environment variables
                        String dbHost = System.getenv("DB_HOST");         // e.g., "localhost"
                        String dbPort = System.getenv("DB_PORT");         // e.g., "3306"
                        String dbName = System.getenv("DB_NAME");         // e.g., "library"
                        String dbUser = System.getenv("DB_USER");         // e.g., "root"
                        String dbPassword = System.getenv("DB_PASSWORD"); // e.g., "admin"

                        String jdbcURL = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;

                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM book");

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("bookid")%></td>
                    <td><%= rs.getString("bookTitle")%></td>
                    <td><%= rs.getString("bookAuthor")%></td>
                    <td><%= rs.getDate("datePublished")%></td>
                    <td><%= rs.getString("synopsis")%></td>
                    <td>
                        <a href="edit-form.jsp?bookid=<%= rs.getInt("bookid")%>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="DeleteBookServlet?bookid=<%= rs.getInt("bookid")%>" class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this book?');">Delete</a>
                    </td>
                </tr>
                <%
                        }

                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='6'>Error loading books: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>

        </table>

        <!-- Back Button -->
        <div class="mt-4">
            <a href="book-form.jsp" class="btn btn-secondary">⬅ Back</a>
        </div>

    </body>
</html>
