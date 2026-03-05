package dao;

import model.EventPackage;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventPackageDAO {

    /**
     * DATABASE UPDATE REQUIRED:
     * ALTER TABLE event_packages ADD COLUMN image VARCHAR(255);
     */

    public boolean addEventPackage(EventPackage event) {
        String sql = "INSERT INTO event_packages (name, price, description, image) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, event.getName());
            ps.setDouble(2, event.getPrice());
            ps.setString(3, event.getDescription());
            ps.setString(4, event.getImage());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EventPackage> getAllEventPackages() {
        List<EventPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM event_packages";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                EventPackage event = mapResultSetToEventPackage(rs);
                list.add(event);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public EventPackage getEventPackageById(int eventId) {
        String sql = "SELECT * FROM event_packages WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEventPackage(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateEventPackage(EventPackage event) {
        String sql = "UPDATE event_packages SET name = ?, price = ?, description = ?, image = ? WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, event.getName());
            ps.setDouble(2, event.getPrice());
            ps.setString(3, event.getDescription());
            ps.setString(4, event.getImage());
            ps.setInt(5, event.getEventId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEventPackage(int eventId) {
        String sql = "DELETE FROM event_packages WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EventPackage> getEventsWithPagination(int offset, int limit) {
        List<EventPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM event_packages LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToEventPackage(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalEventCount() {
        String sql = "SELECT COUNT(*) FROM event_packages";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<EventPackage> searchEventPackages(String query) {
        List<EventPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM event_packages WHERE name LIKE ? OR description LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchTerm = "%" + query + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToEventPackage(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private EventPackage mapResultSetToEventPackage(ResultSet rs) throws SQLException {
        EventPackage event = new EventPackage();
        event.setEventId(rs.getInt("event_id"));
        event.setName(rs.getString("name"));
        event.setPrice(rs.getDouble("price"));
        event.setDescription(rs.getString("description"));
        event.setImage(rs.getString("image"));
        return event;
    }
}