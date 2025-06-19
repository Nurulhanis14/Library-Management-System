package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookidStr = request.getParameter("bookid");
        System.out.println("bookid from request: " + bookidStr); // ✅ DEBUG

        if (bookidStr == null || bookidStr.isEmpty()) {
            System.out.println("Book ID is missing in request");
            response.sendRedirect("book-listing.jsp");
            return;
        }

        int bookid = Integer.parseInt(bookidStr);

        try (Connection con = DBConnection.getConnection()) {

            // 🔁 DEBUG DELETE from borrow
            String deleteBorrowSql = "DELETE FROM borrow WHERE bookid = ?";
            try (PreparedStatement psBorrow = con.prepareStatement(deleteBorrowSql)) {
                psBorrow.setInt(1, bookid);
                int affectedBorrow = psBorrow.executeUpdate();
                System.out.println("Deleted " + affectedBorrow + " borrow record(s)");
            }

            // 🔁 DEBUG DELETE from book
            String deleteBookSql = "DELETE FROM book WHERE bookid = ?";
            try (PreparedStatement psBook = con.prepareStatement(deleteBookSql)) {
                psBook.setInt(1, bookid);
                int affectedBook = psBook.executeUpdate();
                System.out.println("Deleted " + affectedBook + " book record(s)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("book-listing.jsp");
    }
}
