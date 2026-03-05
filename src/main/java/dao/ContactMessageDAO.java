package dao;

import model.ContactMessage;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {

    public boolean addMessage(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return false;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, msg.getName());
                ps.setString(2, msg.getEmail());
                ps.setString(3, msg.getSubject());
                ps.setString(4, msg.getMessage());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ContactMessage> searchMessages(String query) {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages WHERE name LIKE ? OR email LIKE ? OR subject LIKE ? OR message LIKE ? ORDER BY message_id DESC";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return list;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                String q = "%" + query + "%";
                ps.setString(1, q);
                ps.setString(2, q);
                ps.setString(3, q);
                ps.setString(4, q);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        ContactMessage msg = new ContactMessage();
                        msg.setMessageId(rs.getInt("message_id"));
                        msg.setName(rs.getString("name"));
                        msg.setEmail(rs.getString("email"));
                        msg.setSubject(rs.getString("subject"));
                        msg.setMessage(rs.getString("message"));
                        try {
                            msg.setCreatedAt(rs.getTimestamp("created_at"));
                        } catch (SQLException ex) {
                            msg.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
                        }
                        list.add(msg);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY message_id DESC";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return list;
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ContactMessage msg = new ContactMessage();
                    msg.setMessageId(rs.getInt("message_id"));
                    msg.setName(rs.getString("name"));
                    msg.setEmail(rs.getString("email"));
                    msg.setSubject(rs.getString("subject"));
                    msg.setMessage(rs.getString("message"));
                    try {
                        msg.setCreatedAt(rs.getTimestamp("created_at"));
                    } catch (SQLException ex) {
                        msg.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
                    }
                    list.add(msg);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteMessage(int id) {
        String sql = "DELETE FROM contact_messages WHERE message_id = ?";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return false;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
