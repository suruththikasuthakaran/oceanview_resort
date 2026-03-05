package dao;

import model.Rooms;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomsDAO {

    // Insert new room
    public boolean addRoom(Rooms room) {
        String sql = "INSERT INTO rooms (room_number, room_type, price, capacity, bed_type, description, status, image) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, room.getRoomNumber());
            pst.setString(2, room.getRoomType());
            pst.setDouble(3, room.getPrice());
            pst.setInt(4, room.getCapacity());
            pst.setString(5, room.getBedType());
            pst.setString(6, room.getDescription());
            pst.setString(7, room.getStatus());
            pst.setString(8, room.getImage());

            int rows = pst.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update existing room
    public boolean updateRoom(Rooms room) {
        String sql = "UPDATE rooms SET room_number=?, room_type=?, price=?, capacity=?, bed_type=?, description=?, status=?, image=? " +
                "WHERE room_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, room.getRoomNumber());
            pst.setString(2, room.getRoomType());
            pst.setDouble(3, room.getPrice());
            pst.setInt(4, room.getCapacity());
            pst.setString(5, room.getBedType());
            pst.setString(6, room.getDescription());
            pst.setString(7, room.getStatus());
            pst.setString(8, room.getImage());
            pst.setInt(9, room.getRoomId());

            int rows = pst.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a room
    public boolean deleteRoom(int roomId) {
        String sql = "DELETE FROM rooms WHERE room_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, roomId);
            int rows = pst.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all rooms
    public List<Rooms> getAllRooms() {
        List<Rooms> roomsList = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY room_id DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Rooms room = new Rooms(
                        rs.getInt("room_id"),
                        rs.getString("room_number"),
                        rs.getString("room_type"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
                        rs.getString("bed_type"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getString("image")
                );
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));
                roomsList.add(room);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roomsList;
    }

    // Get room by ID
    public Rooms getRoomById(int roomId) {
        String sql = "SELECT * FROM rooms WHERE room_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, roomId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Rooms room = new Rooms(
                        rs.getInt("room_id"),
                        rs.getString("room_number"),
                        rs.getString("room_type"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
                        rs.getString("bed_type"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getString("image")
                );
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));
                return room;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Search rooms by availability or type
    public List<Rooms> searchRooms(String roomNumber, String roomType, String status) {
        List<Rooms> roomsList = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE room_number LIKE ? AND room_type LIKE ? AND status LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, "%" + roomNumber + "%");
            pst.setString(2, "%" + roomType + "%");
            pst.setString(3, "%" + status + "%");
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Rooms room = new Rooms(
                        rs.getInt("room_id"),
                        rs.getString("room_number"),
                        rs.getString("room_type"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
                        rs.getString("bed_type"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getString("image")
                );
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));
                roomsList.add(room);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roomsList;
    }

    // Get paginated rooms for the public frontend
    public List<Rooms> getPaginatedRooms(int offset, int limit) {
        List<Rooms> roomsList = new ArrayList<>();
        // In SQL Server, LIMIT/OFFSET varies, but we'll use a standard syntax. 
        // Note: For older SQL Server you might need ROW_NUMBER(), for generic MySQL/Postgres LIMIT OFFSET works.
        // Assuming MySQL here based on typical simple setups:
        String sql = "SELECT * FROM rooms ORDER BY room_id DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, limit);
            pst.setInt(2, offset);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Rooms room = new Rooms(
                        rs.getInt("room_id"),
                        rs.getString("room_number"),
                        rs.getString("room_type"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
                        rs.getString("bed_type"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getString("image")
                );
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));
                roomsList.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roomsList;
    }

    public int getTotalRoomsCount() {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if(rs.next()) {
                 return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getAvailableRoomsCount() {
        String sql = "SELECT COUNT(*) FROM rooms WHERE status = 'AVAILABLE'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if(rs.next()) {
                 return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getLatestRoomNumber() {
        String sql = "SELECT room_number FROM rooms ORDER BY room_id DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getString("room_number");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "100"; // Default start if no rooms exist
    }
}