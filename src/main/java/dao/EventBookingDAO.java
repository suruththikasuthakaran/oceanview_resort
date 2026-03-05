package dao;

import model.EventBooking;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventBookingDAO {
    private static EventBookingDAO instance;

    private EventBookingDAO() {}

    public static EventBookingDAO getInstance() {
        if (instance == null) {
            instance = new EventBookingDAO();
        }
        return instance;
    }

    public boolean addBooking(EventBooking booking) {
        String sql = "INSERT INTO event_bookings (user_id, event_id, phone, guests, event_date, special_requests, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, booking.getUserId());
            stmt.setInt(2, booking.getEventId());
            stmt.setString(3, booking.getPhone());
            stmt.setInt(4, booking.getGuests());
            stmt.setDate(5, new java.sql.Date(booking.getEventDate().getTime()));
            stmt.setString(6, booking.getSpecialRequests());
            stmt.setString(7, booking.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EventBooking> getAllBookingsJoined() {
        List<EventBooking> list = new ArrayList<>();
        String sql = "SELECT eb.*, u.username, u.full_name as user_full_name, ep.name as event_name, ep.price as event_price " +
                     "FROM event_bookings eb " +
                     "JOIN users u ON eb.user_id = u.user_id " +
                     "JOIN event_packages ep ON eb.event_id = ep.event_id " +
                     "ORDER BY eb.event_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowJoined(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<EventBooking> searchBookingsJoined(String query) {
        List<EventBooking> list = new ArrayList<>();
        String sql = "SELECT eb.*, u.username, u.full_name as user_full_name, ep.name as event_name, ep.price as event_price " +
                     "FROM event_bookings eb " +
                     "JOIN users u ON eb.user_id = u.user_id " +
                     "JOIN event_packages ep ON eb.event_id = ep.event_id " +
                     "WHERE u.full_name LIKE ? OR eb.phone LIKE ? OR ep.name LIKE ? " +
                     "ORDER BY eb.event_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String q = "%" + query + "%";
            ps.setString(1, q);
            ps.setString(2, q);
            ps.setString(3, q);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowJoined(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private EventBooking mapRowJoined(ResultSet rs) throws SQLException {
        EventBooking b = new EventBooking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setEventId(rs.getInt("event_id"));
        b.setPhone(rs.getString("phone"));
        b.setGuests(rs.getInt("guests"));
        b.setEventDate(rs.getDate("event_date"));
        b.setSpecialRequests(rs.getString("special_requests"));
        b.setStatus(rs.getString("status"));
        
        // Populate transient fields from joined results
        try {
            b.setUserFullName(rs.getString("user_full_name"));
            b.setEventName(rs.getString("event_name"));
        } catch (SQLException e) {
            // These columns might not exist in all queries, that's fine
        }
        
        return b;
    }
}
