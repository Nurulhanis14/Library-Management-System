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

@WebServlet("/account_deleted")
public class DeleteAccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection info from environment variables
    private String jdbcURL = "jdbc:mysql://"
            + System.getenv("DB_HOST") + ":"
            + System.getenv("DB_PORT") + "/"
            + System.getenv("DB_NAME");

    private String jdbcUsername = System.getenv("DB_USER");
    private String jdbcPassword = System.getenv("DB_PASSWORD");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");

        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "DELETE FROM users WHERE user_id = ?";
            pst = con.prepareStatement(sql);
            pst.setString(1, userId);

            int rowsDeleted = pst.executeUpdate();

            if (rowsDeleted > 0) {
                // Successfully deleted
                response.sendRedirect("account_deleted.jsp");
            } else {
                response.getWriter().println("Error: User not found or could not delete.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
