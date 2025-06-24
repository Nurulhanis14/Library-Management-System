package com.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection myConnection = null;

    // Read environment variables
    private static final String HOST = System.getenv("DB_HOST");       // e.g., "localhost"
    private static final String PORT = System.getenv("DB_PORT");       // e.g., "3306"
    private static final String DB_NAME = System.getenv("DB_NAME");    // e.g., "book_management"
    private static final String USER = System.getenv("DB_USER");       // e.g., "root"
    private static final String PASSWORD = System.getenv("DB_PASSWORD"); // e.g., "" or "admin"

    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME;

    // Private constructor to prevent instantiation
    private DBConnection() {}

    public static Connection getConnection() throws ClassNotFoundException {
        try {
            if (myConnection == null || myConnection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                myConnection = DriverManager.getConnection(URL, USER, PASSWORD);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return myConnection;
    }

    public static void closeConnection() {
        try {
            if (myConnection != null && !myConnection.isClosed()) {
                myConnection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

    


