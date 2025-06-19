<%@page import="com.Model.Staff"%>
<%@page import="com.Model.User"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User users = (com.Model.User) session.getAttribute("user");
    Staff staff = (com.Model.Staff) session.getAttribute("staff");
    if (users == null && staff == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book Listing</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, Helvetica, sans-serif;
                margin: 0;
            }

            .content {
                background-color: #003366;
                color: white;
            }

            .book-table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
            }

            .book-table th, .book-table td {
                border: 1px solid #ccc;
                padding: 12px;
                text-align: center;
            }

            .book-table th {
                background-color: #003366;
                color: white;
            }

            .btn-sm {
                padding: 5px 10px;
            }

            .container h2 {
                margin-top: 20px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <!-- Header and Navbar -->
        <div class="content">
            <h4 class="header" style="color: white">Universiti Malaysia Terengganu Library</h4>
            <nav class="navbar navbar-expand-lg" style="font-size: 20px; background-color:#003366 !important;">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.html">
                        <img src="logo2.png" alt="Logo" width="120" height="96">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse rounded" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item"><a class="nav-link" style="color:white" href="Homepage1.jsp">Home</a></li>
                            <li class="nav-item"><a class="nav-link" style="color:white" href="AboutUs.jsp">About Us</a></li>
                            <li class="nav-item"><a class="nav-link" style="color:white" href="ContactUs.jsp">Contact Us</a></li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" style="color:white" href="#" role="button" data-bs-toggle="dropdown">Collection</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="BookListing.jsp">Our Collection</a></li>
                                </ul>
                            </li>
                        </ul>
                        <form class="d-flex" role="search">
                            <input class="form-control me-2" type="search" placeholder="Search..." aria-label="Search">
                            <a href="BookListing.jsp" class="btn border me-2" style="background-color: #012a57; color:white">Search</a>
                            <a href="login.html" class="btn border me-2" style="background-color: #012a57; color:white">Login</a>
                        </form>
                    </div>
                </div>
            </nav>
        </div>

        <div class="container">
            <h2>List of Books</h2>
            <table class="book-table">
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
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM book");

                            while (rs.next()) {
                                int bookid = rs.getInt("bookid");
                    %>
                    <tr>
                        <td><%= bookid%></td>
                        <td><%= rs.getString("bookTitle")%></td>
                        <td><%= rs.getString("bookAuthor")%></td>
                        <td><%= rs.getDate("datePublished")%></td>
                        <td><%= rs.getString("synopsis")%></td>
                        <td>
                            <form action="BorrowConfirmation.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="bookid" value="<%= bookid%>">
                                <%
                                    int userid = 0;
                                    if (users != null) {
                                        userid = users.getUserid(); // or getId(), based on your method
                                    } else if (staff != null) {
                                        userid = staff.getStaffid(); // or getId()
                                    } else {
                                        response.sendRedirect("login.jsp"); // not logged in
                                        return;
                                    }
                                %>

                                <input type="hidden" name="userid" value="<%= userid%>">

                                <button type="submit" class="btn btn-success btn-sm">Borrow</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    %>
                    <tr><td colspan="6" class="text-danger">Error loading books: <%= e.getMessage()%></td></tr>
                    <%
                        } finally {
                            if (rs != null) try {
                                rs.close();
                            } catch (Exception e) {
                            }
                            if (stmt != null) try {
                                stmt.close();
                            } catch (Exception e) {
                            }
                            if (conn != null) try {
                                conn.close();
                            } catch (Exception e) {
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
