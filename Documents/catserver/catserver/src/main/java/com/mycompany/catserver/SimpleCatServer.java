/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.catserver;

/**
 *
 * @author SANIA
 */
// Import statements - these bring in pre-built Java classes we need
import com.sun.net.httpserver.*;  // Classes for creating HTTP web servers
import java.io.*;                 // Classes for input/output operations (reading files, streams)
import java.net.*;                // Classes for network operations (URLs, sockets)
import java.sql.*;                // Classes for database connections and SQL operations
import java.util.*;               // Classes for collections, utilities

// Main class that contains our entire web server with best fit ranking system
public class SimpleCatServer {
    
    // Database connection constants for local XAMPP
    private static final String URL = "jdbc:mysql://localhost:3306/cat_adoption";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    
    static {
        try {
            // Explicitly load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ MySQL driver not found! Make sure mysql-connector-j-8.2.0.jar is in classpath");
            System.err.println("   Compile: javac -cp mysql-connector-j-8.2.0.jar SimpleCatServer.java");
            System.err.println("   Run: java -cp \"mysql-connector-j-8.2.0.jar:.\" SimpleCatServer");
        }
    }
    
    // Main method - this is where the program starts when you run 'java SimpleCatServer'
    public static void main(String[] args) throws IOException {
        System.out.println("🐱 Starting Cat Adoption Server...");
        
        // Get port from environment variable (for cloud deployment) or use 8080 for local
        int port = getPort();
        System.out.println("🌐 Server will run on port: " + port);
        
        // Test database connection first
        System.out.println("🔌 Testing database connection...");
        try (Connection conn = getDatabaseConnection()) {
            System.out.println("✅ Successfully connected to database!");
            
            // Test if cats table exists
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM cats");
            if (rs.next()) {
                int catCount = rs.getInt("count");
                System.out.println("📊 Found " + catCount + " cats in database");
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Cannot connect to database!");
            System.err.println("   Error: " + e.getMessage());
            System.err.println("   Please make sure:");
            System.err.println("   1. Database is running");
            System.err.println("   2. Database 'cat_adoption' exists");
            System.err.println("   3. Table 'cats' exists with sample data");
            System.exit(1);
        }
        
        // Create HTTP server with dynamic port
        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
        
        // Set up URL routes - these tell the server what to do for different URLs
        server.createContext("/", new FileHandler());                    // Serves HTML files
        server.createContext("/api/cats", new CatsHandler());            // Returns all cats as JSON
        server.createContext("/api/match-cats", new MatchHandler());     // Finds matching cats with rankings
        server.createContext("/api/health", new HealthHandler());        // Health check endpoint
        
        server.setExecutor(null);
        server.start();
        
        System.out.println("🚀 Server running at http://localhost:" + port + "/");
        System.out.println("📱 Your website: http://localhost:" + port + "/");
        System.out.println("🔍 Health check: http://localhost:" + port + "/api/health");
        System.out.println("🐱 All cats API: http://localhost:" + port + "/api/cats");
        System.out.println("⏹️  Press Ctrl+C to stop");
    }
    
    // Get port number - cloud services provide this via environment variable
    private static int getPort() {
        String portStr = System.getenv("PORT");
        if (portStr != null && !portStr.trim().isEmpty()) {
            try {
                int port = Integer.parseInt(portStr.trim());
                System.out.println("🌐 Using cloud-assigned port: " + port);
                return port;
            } catch (NumberFormatException e) {
                System.out.println("⚠️ Invalid PORT environment variable, using default 8080");
            }
        }
        System.out.println("🏠 Using local development port: 8080");
        return 8080;
    }
    
    // Get database connection (cloud or local)
    private static Connection getDatabaseConnection() throws SQLException {
        String cloudUrl = System.getenv("DATABASE_URL");
        String cloudUsername = System.getenv("DB_USERNAME");
        String cloudPassword = System.getenv("DB_PASSWORD");
        
        if (cloudUrl != null && cloudUsername != null && cloudPassword != null) {
            // Use cloud database
            System.out.println("🌐 Connecting to cloud database...");
            return DriverManager.getConnection(cloudUrl, cloudUsername, cloudPassword);
        } else {
            // Use local XAMPP for development
            System.out.println("🏠 Connecting to local XAMPP database...");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        }
    }
    
    // Handler class for serving static files (HTML, CSS, etc.)
    static class FileHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String path = exchange.getRequestURI().getPath();
            
            // Default to index.html for root path
            if ("/".equals(path)) {
                path = "/index.html";
            }
            
            try {
                File file = new File("." + path);
                
                if (file.exists() && file.isFile()) {
                    // Determine content type
                    String contentType = "text/html";
                    if (path.endsWith(".css")) contentType = "text/css";
                    if (path.endsWith(".js")) contentType = "application/javascript";
                    
                    // Read and serve file
                    byte[] fileBytes = java.nio.file.Files.readAllBytes(file.toPath());
                    exchange.getResponseHeaders().set("Content-Type", contentType);
                    exchange.sendResponseHeaders(200, fileBytes.length);
                    
                    try (OutputStream os = exchange.getResponseBody()) {
                        os.write(fileBytes);
                    }
                    
                    System.out.println("📄 Served: " + path);
                } else {
                    // File not found
                    String notFound = "<h1>404 - File Not Found</h1><p>Could not find: " + path + "</p>";
                    exchange.sendResponseHeaders(404, notFound.getBytes().length);
                    try (OutputStream os = exchange.getResponseBody()) {
                        os.write(notFound.getBytes());
                    }
                }
            } catch (Exception e) {
                String error = "<h1>500 - Server Error</h1><p>" + e.getMessage() + "</p>";
                exchange.sendResponseHeaders(500, error.getBytes().length);
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(error.getBytes());
                }
                e.printStackTrace();
            }
        }
    }
    
    // Handler for health check endpoint
    static class HealthHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            // Enable CORS
            exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
            exchange.getResponseHeaders().add("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
            exchange.getResponseHeaders().add("Access-Control-Allow-Headers", "Content-Type");
            
            String response = "{\"status\": \"OK\", \"message\": \"Java Cat Adoption API is running!\"}";
            exchange.getResponseHeaders().set("Content-Type", "application/json");
            exchange.sendResponseHeaders(200, response.getBytes().length);
            
            try (OutputStream os = exchange.getResponseBody()) {
                os.write(response.getBytes());
            }
            
            System.out.println("💓 Health check requested");
        }
    }
    
    // Handler to get all available cats from the database
    static class CatsHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            // Enable CORS
            exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
            exchange.getResponseHeaders().add("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
            exchange.getResponseHeaders().add("Access-Control-Allow-Headers", "Content-Type");
            
            if ("OPTIONS".equals(exchange.getRequestMethod())) {
                exchange.sendResponseHeaders(200, -1);
                return;
            }
            
            try (Connection conn = getDatabaseConnection()) {
                String sql = "SELECT * FROM cats WHERE adopted = 0 OR adopted IS NULL";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                
                StringBuilder jsonResponse = new StringBuilder("[");
                boolean first = true;
                
                while (rs.next()) {
                    if (!first) {
                        jsonResponse.append(",");
                    }
                    
                    jsonResponse.append("{")
                        .append("\"id\":").append(rs.getLong("id")).append(",")
                        .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                        .append("\"age\":").append(rs.getInt("age")).append(",")
                        .append("\"gender\":\"").append(escapeJson(rs.getString("gender"))).append("\",")
                        .append("\"temperament\":\"").append(escapeJson(rs.getString("temperament"))).append("\",")
                        .append("\"description\":\"").append(escapeJson(rs.getString("description"))).append("\",")
                        .append("\"goodWithChildren\":").append(rs.getBoolean("good_with_children")).append(",")
                        .append("\"goodWithDogs\":").append(rs.getBoolean("good_with_dogs")).append(",")
                        .append("\"goodWithCats\":").append(rs.getBoolean("good_with_cats")).append(",")
                        .append("\"specialNeeds\":").append(rs.getBoolean("special_needs"))
                        .append("}");
                    
                    first = false;
                }
                jsonResponse.append("]");
                
                String response = jsonResponse.toString();
                exchange.getResponseHeaders().set("Content-Type", "application/json");
                exchange.sendResponseHeaders(200, response.getBytes().length);
                
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(response.getBytes());
                }
                
                System.out.println("🐱 Served " + (first ? 0 : "multiple") + " cats from database");
                
            } catch (SQLException e) {
                System.err.println("❌ Database error: " + e.getMessage());
                String errorResponse = "{\"error\": \"Database connection failed\"}";
                exchange.sendResponseHeaders(500, errorResponse.getBytes().length);
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(errorResponse.getBytes());
                }
            }
        }
    }
    
    // BEST FIT RANKING SYSTEM - Match cats based on preferences with scoring
    static class MatchHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            // Enable CORS
            exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
            exchange.getResponseHeaders().add("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
            exchange.getResponseHeaders().add("Access-Control-Allow-Headers", "Content-Type");
            
            if ("OPTIONS".equals(exchange.getRequestMethod())) {
                exchange.sendResponseHeaders(200, -1);
                return;
            }
            
            if ("POST".equals(exchange.getRequestMethod())) {
                try {
                    String requestBody = new String(exchange.getRequestBody().readAllBytes());
                    System.out.println("📨 Received match request: " + requestBody);
                    
                    // Parse user preferences from JSON
                    boolean hasChildren = requestBody.contains("\"hasChildren\":true");
                    boolean hasDogs = requestBody.contains("\"hasDogs\":true");
                    boolean hasCats = requestBody.contains("\"hasCats\":true");
                    boolean isQuietEnvironment = requestBody.contains("\"environment\":\"quiet\"");
                    boolean isActiveEnvironment = requestBody.contains("\"environment\":\"very_active\"");
                    boolean notOpenToSpecialNeeds = requestBody.contains("\"specialNeeds\":\"not_open\"");
                    String experience = "no_experience"; // Default
                    if (requestBody.contains("\"experience\":\"very_experienced\"")) experience = "very_experienced";
                    if (requestBody.contains("\"experience\":\"somewhat_experienced\"")) experience = "somewhat_experienced";
                    
                    // Get ALL available cats (no filtering - we'll rank them all)
                    try (Connection conn = getDatabaseConnection()) {
                        String sql = "SELECT * FROM cats WHERE (adopted = 0 OR adopted IS NULL)";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();
                        
                        // List to store cats with their compatibility scores
                        java.util.List<CatWithScore> rankedCats = new java.util.ArrayList<>();
                        
                        while (rs.next()) {
                            // Calculate compatibility score for each cat
                            int score = calculateCompatibilityScore(
                                rs.getString("name"),
                                rs.getInt("age"),
                                rs.getString("temperament"),
                                rs.getBoolean("good_with_children"),
                                rs.getBoolean("good_with_dogs"),
                                rs.getBoolean("good_with_cats"),
                                rs.getBoolean("special_needs"),
                                hasChildren, hasDogs, hasCats, 
                                isQuietEnvironment, isActiveEnvironment, 
                                notOpenToSpecialNeeds, experience
                            );
                            
                            // Only include cats with positive scores (some compatibility)
                            if (score > 0) {
                                rankedCats.add(new CatWithScore(
                                    rs.getLong("id"),
                                    rs.getString("name"),
                                    rs.getInt("age"),
                                    rs.getString("gender"),
                                    rs.getString("temperament"),
                                    rs.getString("description"),
                                    rs.getBoolean("good_with_children"),
                                    rs.getBoolean("good_with_dogs"),
                                    rs.getBoolean("good_with_cats"),
                                    rs.getBoolean("special_needs"),
                                    score
                                ));
                            }
                        }
                        
                        // Sort by compatibility score (highest first) - BEST FIT RANKING!
                        rankedCats.sort((cat1, cat2) -> Integer.compare(cat2.score, cat1.score));
                        
                        // Take top 10 best matches
                        if (rankedCats.size() > 10) {
                            rankedCats = rankedCats.subList(0, 10);
                        }
                        
                        // Build JSON response with rankings
                        StringBuilder jsonResponse = new StringBuilder("[");
                        boolean first = true;
                        int rank = 1;
                        
                        for (CatWithScore cat : rankedCats) {
                            if (!first) jsonResponse.append(",");
                            
                            // Calculate match percentage (score out of maximum possible score)
                            int maxPossibleScore = 100; // Maximum points a cat can get
                            int matchPercentage = Math.min(100, (cat.score * 100) / maxPossibleScore);
                            String matchLevel = getMatchLevel(matchPercentage);
                            
                            jsonResponse.append("{")
                                .append("\"id\":").append(cat.id).append(",")
                                .append("\"name\":\"").append(escapeJson(cat.name)).append("\",")
                                .append("\"age\":").append(cat.age).append(",")
                                .append("\"gender\":\"").append(escapeJson(cat.gender)).append("\",")
                                .append("\"temperament\":\"").append(escapeJson(cat.temperament)).append("\",")
                                .append("\"description\":\"").append(escapeJson(cat.description)).append("\",")
                                .append("\"rank\":").append(rank).append(",")
                                .append("\"compatibilityScore\":").append(cat.score).append(",")
                                .append("\"matchPercentage\":").append(matchPercentage).append(",")
                                .append("\"matchLevel\":\"").append(matchLevel).append("\",")
                                .append("\"goodWithChildren\":").append(cat.goodWithChildren).append(",")
                                .append("\"goodWithDogs\":").append(cat.goodWithDogs).append(",")
                                .append("\"goodWithCats\":").append(cat.goodWithCats).append(",")
                                .append("\"specialNeeds\":").append(cat.specialNeeds)
                                .append("}");
                            
                            first = false;
                            rank++;
                        }
                        jsonResponse.append("]");
                        
                        String response = jsonResponse.toString();
                        exchange.getResponseHeaders().set("Content-Type", "application/json");
                        exchange.sendResponseHeaders(200, response.getBytes().length);
                        
                        try (OutputStream os = exchange.getResponseBody()) {
                            os.write(response.getBytes());
                        }
                        
                        System.out.println("✅ Found " + rankedCats.size() + " cats, ranked by best fit");
                        
                    } catch (SQLException e) {
                        System.err.println("❌ Database error: " + e.getMessage());
                        String errorResponse = "{\"error\": \"Database query failed: " + e.getMessage() + "\"}";
                        exchange.sendResponseHeaders(500, errorResponse.getBytes().length);
                        try (OutputStream os = exchange.getResponseBody()) {
                            os.write(errorResponse.getBytes());
                        }
                    }
                    
                } catch (Exception e) {
                    System.err.println("❌ Request processing error: " + e.getMessage());
                    String errorResponse = "{\"error\": \"Failed to process request: " + e.getMessage() + "\"}";
                    exchange.sendResponseHeaders(500, errorResponse.getBytes().length);
                    try (OutputStream os = exchange.getResponseBody()) {
                        os.write(errorResponse.getBytes());
                    }
                    e.printStackTrace();
                }
            } else {
                exchange.sendResponseHeaders(405, -1);
            }
        }
    }
    
    // COMPATIBILITY SCORING SYSTEM - Awards points for good matches
    private static int calculateCompatibilityScore(String catName, int catAge, String temperament,
                                                 boolean goodWithChildren, boolean goodWithDogs, boolean goodWithCats,
                                                 boolean specialNeeds, boolean userHasChildren, boolean userHasDogs,
                                                 boolean userHasCats, boolean userWantsQuiet, boolean userWantsActive,
                                                 boolean userNotOpenToSpecialNeeds, String userExperience) {
        int score = 0;
        
        // MANDATORY COMPATIBILITY CHECKS (if these fail, cat gets 0 score)
        if (userHasChildren && !goodWithChildren) return 0;  // Must be good with children
        if (userHasDogs && !goodWithDogs) return 0;          // Must be good with dogs  
        if (userHasCats && !goodWithCats) return 0;          // Must be good with other cats
        if (userNotOpenToSpecialNeeds && specialNeeds) return 0; // User doesn't want special needs
        
        // SCORING SYSTEM - Add points for good matches
        
        // Household compatibility (20 points each)
        if (userHasChildren && goodWithChildren) score += 20;
        if (userHasDogs && goodWithDogs) score += 20;
        if (userHasCats && goodWithCats) score += 20;
        
        // Environment matching (15 points)
        if (temperament != null) {
            String tempLower = temperament.toLowerCase();
            if (userWantsQuiet && (tempLower.contains("lap_cat") || tempLower.contains("independent"))) {
                score += 15;
            }
            if (userWantsActive && (tempLower.contains("sassy") || tempLower.contains("spirit_cat"))) {
                score += 15;
            }
        }
        
        // Age preferences based on experience (10 points)
        if ("very_experienced".equals(userExperience)) {
            score += 10; // Experienced users can handle any cat
        } else if ("somewhat_experienced".equals(userExperience)) {
            if (catAge >= 2 && catAge <= 8) score += 10; // Adult cats are easier
        } else { // no_experience
            if (catAge >= 3 && catAge <= 6 && !specialNeeds) score += 10; // Young adult, healthy cats
        }
        
        // Bonus points for special situations (5 points each)
        if (!specialNeeds) score += 5; // Bonus for healthy cats
        if (catAge >= 5) score += 3;   // Bonus for giving older cats a chance
        
        // Base compatibility score (every cat gets some points for being available)
        score += 10;
        
        return score;
    }
    
    // Determine match level based on percentage
    private static String getMatchLevel(int percentage) {
        if (percentage >= 90) return "Perfect Match";
        if (percentage >= 75) return "Excellent Match";
        if (percentage >= 60) return "Great Match";
        if (percentage >= 45) return "Good Match";
        return "Fair Match";
    }
    
    // Class to hold cat data with compatibility score
    private static class CatWithScore {
        long id;
        String name, gender, temperament, description;
        int age, score;
        boolean goodWithChildren, goodWithDogs, goodWithCats, specialNeeds;
        
        CatWithScore(long id, String name, int age, String gender, String temperament, String description,
                    boolean goodWithChildren, boolean goodWithDogs, boolean goodWithCats, boolean specialNeeds, int score) {
            this.id = id;
            this.name = name;
            this.age = age;
            this.gender = gender;
            this.temperament = temperament;
            this.description = description;
            this.goodWithChildren = goodWithChildren;
            this.goodWithDogs = goodWithDogs;
            this.goodWithCats = goodWithCats;
            this.specialNeeds = specialNeeds;
            this.score = score;
        }
    }
    
    // Helper method to make strings safe for JSON
    private static String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"")     // Replace " with \"
                  .replace("\\", "\\\\")     // Replace \ with \\
                  .replace("\b", "\\b")      // Replace backspace with \b
                  .replace("\f", "\\f")      // Replace form feed with \f
                  .replace("\n", "\\n")      // Replace newline with \n
                  .replace("\r", "\\r")      // Replace carriage return with \r
                  .replace("\t", "\\t");     // Replace tab with \t
    }
}
