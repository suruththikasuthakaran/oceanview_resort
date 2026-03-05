package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.User;
import util.DBConnection;

public class UserDAO {

    public boolean addUser(User user) {
        boolean status = false;
        String sql = "INSERT INTO users (username, password, contact_no, address, email, nic_or_passport, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("UserDAO: Inserting user " + user.getUsername());

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("UserDAO: Connection is null!");
                return false;
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getContactNo());
                ps.setString(4, user.getAddress());
                ps.setString(5, user.getEmail());
                ps.setString(6, user.getNicOrPassport());
                ps.setString(7, user.getRole().name());

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    status = true;
                }
            }
        } catch (SQLException e) {
            System.out.println("UserDAO Error in addUser: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState() + " | Error Code: " + e.getErrorCode());
            e.printStackTrace();
        }
        return status;
    }

    public User login(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        System.out.println("UserDAO: Checking login for " + username);

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return null;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setUserId(rs.getInt("user_id"));
                        user.setUsername(rs.getString("username"));
                        user.setContactNo(rs.getString("contact_no"));
                        user.setAddress(rs.getString("address"));
                        user.setEmail(rs.getString("email"));
                        user.setNicOrPassport(rs.getString("nic_or_passport"));
                        
                        String dbRole = rs.getString("role");
                        if (dbRole != null) {
                            if (dbRole.equalsIgnoreCase("ADMIN")) {
                                user.setRole(model.Role.ADMIN);
                            } else if (dbRole.equalsIgnoreCase("STAFF")) {
                                user.setRole(model.Role.STAFF);
                            } else {
                                user.setRole(model.Role.CUSTOMER);
                            }
                        } else {
                            user.setRole(model.Role.CUSTOMER);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("UserDAO Error in login: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return users;
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setContactNo(rs.getString("contact_no"));
                    user.setAddress(rs.getString("address"));
                    user.setEmail(rs.getString("email"));
                    user.setNicOrPassport(rs.getString("nic_or_passport"));
                    
                    String dbRole = rs.getString("role");
                    if (dbRole != null) {
                        if (dbRole.equalsIgnoreCase("ADMIN")) {
                            user.setRole(model.Role.ADMIN);
                        } else if (dbRole.equalsIgnoreCase("STAFF")) {
                            user.setRole(model.Role.STAFF);
                        } else {
                            user.setRole(model.Role.CUSTOMER);
                        }
                    } else {
                        user.setRole(model.Role.CUSTOMER);
                    }
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            System.out.println("UserDAO Error in getAllUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchUsers(String query) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE username LIKE ? OR contact_no LIKE ? OR email LIKE ? OR nic_or_passport LIKE ? OR role LIKE ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return users;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                String q = "%" + query + "%";
                ps.setString(1, q);
                ps.setString(2, q);
                ps.setString(3, q);
                ps.setString(4, q);
                ps.setString(5, q);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        User user = new User();
                        user.setUserId(rs.getInt("user_id"));
                        user.setUsername(rs.getString("username"));
                        user.setContactNo(rs.getString("contact_no"));
                        user.setAddress(rs.getString("address"));
                        user.setEmail(rs.getString("email"));
                        user.setNicOrPassport(rs.getString("nic_or_passport"));
                        
                        String dbRole = rs.getString("role");
                        if (dbRole != null) {
                            if (dbRole.equalsIgnoreCase("ADMIN")) {
                                user.setRole(model.Role.ADMIN);
                            } else if (dbRole.equalsIgnoreCase("STAFF")) {
                                user.setRole(model.Role.STAFF);
                            } else {
                                user.setRole(model.Role.CUSTOMER);
                            }
                        } else {
                            user.setRole(model.Role.CUSTOMER);
                        }
                        users.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("UserDAO Error in searchUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    // In UserDAO.java
    public boolean deleteUser(int userId) {
        boolean status = false;
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            status = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }
    
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("UserDAO Error in isUsernameExists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}