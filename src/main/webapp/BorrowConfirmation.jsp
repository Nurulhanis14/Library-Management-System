<%@page import="com.Model.User"%>
<%@page import="com.util.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User users = (User) session.getAttribute("user");

    if (users == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userid = users.getUserid();
    String username = users.getUsername();

    String bookidParam = request.getParameter("bookid");
    int bookid = bookidParam != null ? Integer.parseInt(bookidParam) : 0;

    String bookTitle = "";
    String synopsis = "";

    if (bookid > 0) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT bookTitle, synopsis FROM book WHERE bookid = ?");
            ps.setInt(1, bookid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bookTitle = rs.getString("bookTitle");
                synopsis = rs.getString("synopsis");
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error fetching book data: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Borrow Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 0;
        }

        .content {
            background-color: #003166;
            color: white;
        }

        .table th {
            background-color: #003166;
            color: white;
        }

        .btn-submit {
            background-color: #012a57;
            color: white;
        }

        .btn-submit:hover {
            background-color: #01458a;
        }

        .form-container {
            width: 70%;
            margin: 40px auto;
        }
    </style>
</head>
<body>
    <!-- Flash Message -->
    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
        <div class="alert alert-success alert-dismissible fade show text-center w-100 mb-0 rounded-0"
             role="alert"
             style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); width: 60%; z-index: 9999; opacity: 0.95;">
            ✅ <%= msg %>
            <button type="button" class="btn-close" aria-label="Close"
                    onclick="window.location.href = 'BorrowBook.jsp'"></button>
        </div>
    <% } %>

    <!-- Disable button if already submitted -->
    <% if (msg != null && msg.contains("successfully")) { %>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelector("button[type='submit']").disabled = true;
        });
    </script>
    <% } %>

    <!-- Header and Navbar -->
    <div class="content p-3">
        <h4>Universiti Malaysia Terengganu Library</h4>
        <nav class="navbar navbar-expand-lg" style="font-size: 20px; background-color:#003166;">
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
                        <li class="nav-item"><a class="nav-link text-white" href="Homepage1.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="AboutUs.jsp">About Us</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="ContactUs.jsp">Contact Us</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">Collection</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="book listing.html">Our Collection</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex" role="search">
                        <input class="form-control me-2" type="search" placeholder="Search..." aria-label="Search">
                        <a href="book listing.html" class="btn btn-outline-light me-2">Search</a>
                        <a href="login.html" class="btn btn-outline-light">Login</a>
                    </form>
                </div>
            </div>
        </nav>
    </div>

    <!-- Borrow Confirmation Form -->
    <div class="form-container">
        <h2 class="text-center">Borrow Confirmation</h2>
        <form action="BorrowBookServlet" method="post">
            <table class="table table-bordered">
                <tr><th>User ID</th><td><%= userid %></td></tr>
                <tr><th>Username</th><td><%= username %></td></tr>
                <tr><th>Book ID</th><td><%= bookid %></td></tr>
                <tr><th>Book Title</th><td><%= bookTitle %></td></tr>
                <tr><th>Synopsis</th><td><%= synopsis %></td></tr>
            </table>

            <!-- Hidden Inputs -->
            <input type="hidden" name="userid" value="<%= userid %>">
            <input type="hidden" name="bookid" value="<%= bookid %>">

            <!-- Borrow & Return Fields -->
            <div class="mb-3">
                <label for="borrowDate" class="form-label">Select Borrow Date:</label>
                <input type="date" class="form-control" id="borrowDate" name="borrowDate"
                       onchange="setReturnBy()"
                       min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
            </div>

            <div class="mb-3">
                <label for="returnBy" class="form-label">Return By:</label>
                <input type="text" class="form-control" id="returnBy" name="returnBy" readonly>
            </div>

            <button type="submit" class="btn btn-submit">Confirm Borrow</button>
        </form>
    </div>

    <!-- JS to Calculate Return Date -->
<script>
function setReturnBy() {
    const borrowInput = document.getElementById("borrowDate");
    const returnInput = document.getElementById("returnBy");

    const borrowDateValue = borrowInput.value;
    console.log("Selected Borrow Date:", borrowDateValue);

    if (borrowDateValue) {
        const borrowDate = new Date(borrowDateValue);
        console.log("Parsed Date:", borrowDate);

        // Add 14 days
        borrowDate.setDate(borrowDate.getDate() + 14);
        console.log("Return By (raw):", borrowDate);

        // Format date as dd/mm/yy
        const dd = String(borrowDate.getDate()).padStart(2, '0');
        const mm = String(borrowDate.getMonth() + 1).padStart(2, '0');
        const yy = borrowDate.getFullYear().toString().slice(-2);

        const formatted = dd + "/" + mm + "/" + yy;
        console.log("Formatted Return Date:", formatted);

        returnInput.value = formatted;
    } else {
        returnInput.value = "";
    }
}
</script>


</body>
</html>
