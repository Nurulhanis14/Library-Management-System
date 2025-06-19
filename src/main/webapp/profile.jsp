<%@ page import="com.Model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.19.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-card {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .profile-card h2 {
            margin-bottom: 20px;
        }
        .profile-card ul {
            list-style: none;
            padding: 0;
        }
        .profile-card ul li {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

            .main-title {
                background-color: white;
                color: black;
                padding-top: 30px;
                padding-left: 30px;
                border-top-left-radius: 50px;
                margin-left: 100px;
                margin-right: 50px;
                margin-top: -50px; /* Adjust as needed */
                position: relative;
                z-index: 2;
            }
            .remove-decoration {
                text-decoration: none;
            }
            .container{
                margin-top: 50px;
            }
            .sub-title{
                margin-right: 500px;
                /* padding-right: 500px; */
                position: relative;
            }
            .helpful{
                background-color: whitesmoke;
                /* border: 50px; */
                height: fit-content;
                width: 200px;
                border-radius: 10px;
            }
            .end{
                background-color: #003166;
            }
            @media screen and (max-width: 768px) {
                .main-title {
                    margin-right: 0;
                    margin-left: 50px;
                }
                .sub-title{
                    margin-right: 0;
                }
                .right-div{
                    display: none;
                }

            }
            /* Set right margin to 0 for smaller screens */
            .carousel {
                z-index: 1;
            }
            .white-text { /* White text*/
                color: white !important;
            }
            .max-height {
                max-height: 400px; /* Set your desired maximum height */
                min-height: 400px;
                margin: auto; /* Center the image horizontally */
            }
            .header{
                font-family: 'Times New Roman', Times, serif;
            }
            .slideshow{
                max-width: 300px;
                max-height: 300px;
            }
            .right-div {
                color: #003166;
                float: right; /* Set the float property to right */
                max-width: 500px; /* Set a width to the div if needed */
                max-height: 100vh; /* Set a height to the div if needed */
                /* background-color: whitesmoke; */ /* Add background color for visibility */
                margin-right: 100px;
            }

            /* Clear the float to prevent content below from wrapping around */
            .clearfix::after {
                content: "";
                clear: both;
                display: table;
            }

            /* Optional: Apply styles to the content below */
            .content {
                /* Add styles for the content below */
                padding: 20px;
            }
            /* Add hover effect for the navbar */
            .navbar:hover {
                background-color: #007BFF; /* Change the background color on hover */
            }

            /* Add hover effect for the navbar links */
            .navbar a:hover {
                color: blue; /* Change the text color on hover */
            }

            .fa {
                padding: 20px;
                font-size: 50px;
                margin: 10px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                transition: opacity 0.3s;
            }

            /* Add a hover effect if you want */
            .fa:hover {
                opacity: 0.7;
            }
            /* Facebook */
            .fa-facebook {
                background: #3B5998;
                color: white;
            }
            /* Twitter */
            .fa-twitter {
                background: #55ACEE;
                color: white;
            }

            .endcontainer img,
            .endcontainer p {
                display: inline-block;
                vertical-align: middle;
                border-radius: 10px;
                margin-right: 10px;
            }
            .endcontainer{
                padding: 20px;
            }
            .copyright{
                padding: 5px;
                margin-left: 20px;
            }
    </style>
</head>
<body>

<%
    User users = (User) session.getAttribute("user");

    if (users == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

    <!-- Header -->
        <div class="content white-text" style="background-color: #003166;"> <!-- Navigation-->

            <h4 class="header">Universiti Malaysia Terengganu Library</h4>
            <nav class="navbar navbar-expand-lg bg-body-tertiary" style="font-size: 20px;background-color:#003166 !important;">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.html">
                        <img src="logo2.png" alt="Logo" width="120" height="96" class="d-inline-block align-text-middle">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse rounded"  id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
                            <li class="nav-item">
                                <a class="nav-link active white-text" aria-current="page" href="Homepage1.jsp">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link white-text " href="AboutUs.jsp" >About Us</a>
                            </li>
                            <li>
                                <a class="nav-link white-text " href="ContactUs.jsp" >Contact Us</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle white-text" href="#" role="button" 
                                   data-bs-toggle="dropdown" aria-expanded="false">Collection</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="book listing.html">Our Collection</a></li>
                                </ul>
                            </li>
                        </ul>
                        <form class="d-flex" role="search">
                            <input class="form-control me-2" type="search" placeholder="Search..." aria-label="Search">
                            <a href="book listing.html" class="btn border me-2 white-text" style="background-color: #012a57;">Search</a>

                            <a href="profile.jsp" class="btn border me-2" style="background-color: #012a57; color:white">View Profile</a>
                            <a href="BorrowBook.jsp" class="btn border me-2" style="background-color: #012a57; color:white">Borrow Books</a>
                        </form>

                    </div>
                </div>

            </nav>
        </div> 

<div class="container">
    <div class="profile-card text-center">
        <h2>Welcome, <%= users.getUsername() %></h2>
        <ul class="text-start">
            <li><strong>User ID:</strong> <%= users.getUserid() %></li>
            <li><strong>Username:</strong> <%= users.getUsername() %></li>
            <li><strong>Email:</strong> <%= users.getEmail() %></li>
            <li><strong>Phone Number:</strong> <%= users.getPhone() %></li>
            <li><strong>Address:</strong> <%= users.getAddress() %></li>
        </ul>
        <a class="btn btn-danger mt-4" href="Homepage1.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
