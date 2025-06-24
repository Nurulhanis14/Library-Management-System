package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String bookTitle = request.getParameter("bookTitle");
        String bookAuthor = request.getParameter("bookAuthor");
        String datePublished = request.getParameter("datePublished");
        String synopsis = request.getParameter("synopsis"); // ikut nama form & DB

        System.out.println("DEBUG - bookTitle: " + bookTitle); // Tambah log
        System.out.println("DEBUG - bookAuthor: " + bookAuthor);
        System.out.println("DEBUG - datePublished: " + datePublished);
        System.out.println("DEBUG - synopsis: " + synopsis);

        try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Get values from system environment
    String dbHost = System.getenv("DB_HOST");         // e.g. "localhost"
    String dbPort = System.getenv("DB_PORT");         // e.g. "3306"
    String dbName = System.getenv("DB_NAME");         // e.g. "library"
    String dbUser = System.getenv("DB_USER");         // e.g. "root"
    String dbPassword = System.getenv("DB_PASSWORD"); // e.g. "admin"

    // Build the connection string
    String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;

    // Establish connection
    Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

    String sql = "INSERT INTO book (bookTitle, bookAuthor, datePublished, synopsis) VALUES (?, ?, ?, ?)";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, bookTitle);
    stmt.setString(2, bookAuthor);
    stmt.setString(3, datePublished);
    stmt.setString(4, synopsis);

    stmt.executeUpdate();
    conn.close();

    response.sendRedirect("book-listing.jsp");

} catch (Exception e) {
    e.printStackTrace();
    response.getWriter().println("Error: " + e.getMessage());
}

    }
}
