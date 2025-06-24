<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String title = "", author = "", date = "", synopsis = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Get DB config from environment variables
        String dbHost = System.getenv("DB_HOST");
        String dbPort = System.getenv("DB_PORT");
        String dbName = System.getenv("DB_NAME");
        String dbUser = System.getenv("DB_USER");
        String dbPassword = System.getenv("DB_PASSWORD");

        // Build JDBC URL
        String jdbcURL = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;

        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM book WHERE bookid = ?");
        stmt.setInt(1, Integer.parseInt(id));
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("bookTitle");
            author = rs.getString("bookAuthor");
            date = rs.getString("datePublished");
            synopsis = rs.getString("synopsis");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>

<html>
    <head>
        <title>Edit Book</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container mt-5">
        <h2>Edit Book</h2>
        <form action="EditBookServlet" method="post">
            <input type="hidden" name="bookid" value="<%= id%>" />
            <div class="mb-3">
                <label>Title:</label>
                <input type="text" name="bookTitle" class="form-control" value="<%= title%>" required />
            </div>
            <div class="mb-3">
                <label>Author:</label>
                <input type="text" name="bookAuthor" class="form-control" value="<%= author%>" required />
            </div>
            <div class="mb-3">
                <label>Date Published:</label>
                <input type="date" name="datePublished" class="form-control" value="<%= date%>" required />
            </div>
            <div class="mb-3">
                <label>Synopsis:</label>
                <textarea name="synopsis" class="form-control" required><%= synopsis%></textarea>
            </div>
            <button type="submit" class="btn btn-success">Update Book</button>
            <a href="book-listing.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </body>
</html>
