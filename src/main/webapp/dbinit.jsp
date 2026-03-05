<%@ page import="java.sql.*, util.DBConnection" %>
    <% String sql="CREATE TABLE IF NOT EXISTS contact_messages (" + "message_id INT AUTO_INCREMENT PRIMARY KEY, "
        + "name VARCHAR(255) NOT NULL, " + "email VARCHAR(255) NOT NULL, " + "subject VARCHAR(255) NOT NULL, "
        + "message TEXT NOT NULL, " + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" + ")" ; try (Connection
        conn=DBConnection.getConnection(); Statement stmt=conn.createStatement()) { stmt.execute(sql); out.println("<h2>
        Database Initialized Successfully!</h2>");
        out.println("<p>Table <b>contact_messages</b> created or already exists.</p>");
        } catch (Exception e) {
        out.println("<h2>Error Initializing Database:</h2>");
        out.println("
        <pre>" + e.getMessage() + "</pre>");
        e.printStackTrace();
        }
        %>
        <br>
        <a href="index.jsp">Go to Home</a>