package dao;

import model.Reservation;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    /**
     * Generates the next reservation number in format RES-0001, RES-0002, etc.
     */
    public String getNextReservationNo() {
        String sql = "SELECT COUNT(*) FROM reservations";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt(1) + 1;
                return String.format("RES-%04d", count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "RES-0001";
    }

    /**
     * Inserts a new reservation. Returns the generated reservation_id or -1 on failure.
     * Uses a transaction to ensure atomicity.
     */
    public int addReservation(Reservation r) {
        String sql = "INSERT INTO reservations (reservation_no, user_id, full_name, address, email, nic, " +
                     "check_in, check_out, guest_count, room_type, food_package, total_amount, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'PENDING')";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, r.getReservationNo());
                ps.setInt(2, r.getUserId());
                ps.setString(3, r.getFullName());
                ps.setString(4, r.getAddress());
                ps.setString(5, r.getEmail());
                ps.setString(6, r.getNic());
                ps.setDate(7, r.getCheckIn());
                ps.setDate(8, r.getCheckOut());
                ps.setInt(9, r.getGuestCount());
                ps.setString(10, r.getRoomType());
                ps.setString(11, r.getFoodPackage());
                ps.setDouble(12, r.getTotalAmount());

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    ResultSet keys = ps.getGeneratedKeys();
                    if (keys.next()) {
                        int id = keys.getInt(1);
                        conn.commit();
                        return id;
                    }
                }
                conn.rollback();
            }
        } catch (SQLException e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException e) { e.printStackTrace(); }
        }
        return -1;
    }

    public Reservation getByReservationNo(String reservationNo) {
        String sql = "SELECT * FROM reservations WHERE reservation_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reservationNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Reservation getById(int id) {
        String sql = "SELECT * FROM reservations WHERE reservation_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int reservationId, String status) {
        String sql = "UPDATE reservations SET status = ? WHERE reservation_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, reservationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Reservation> searchReservations(String query, String checkIn, String checkOut) {
        List<Reservation> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM reservations WHERE 1=1 ");
        
        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (reservation_no LIKE ? OR full_name LIKE ?) ");
        }
        if (checkIn != null && !checkIn.isEmpty()) {
            sql.append("AND check_in >= ? ");
        }
        if (checkOut != null && !checkOut.isEmpty()) {
            sql.append("AND check_out <= ? ");
        }
        sql.append("ORDER BY created_at DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIdx = 1;
            if (query != null && !query.trim().isEmpty()) {
                String searchTerm = "%" + query + "%";
                ps.setString(paramIdx++, searchTerm);
                ps.setString(paramIdx++, searchTerm);
            }
            if (checkIn != null && !checkIn.isEmpty()) {
                try {
                    ps.setDate(paramIdx++, java.sql.Date.valueOf(checkIn));
                } catch (Exception e) { ps.setNull(paramIdx-1, java.sql.Types.DATE); }
            }
            if (checkOut != null && !checkOut.isEmpty()) {
                try {
                    ps.setDate(paramIdx++, java.sql.Date.valueOf(checkOut));
                } catch (Exception e) { ps.setNull(paramIdx-1, java.sql.Types.DATE); }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Reservation mapRow(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setReservationNo(rs.getString("reservation_no"));
        r.setUserId(rs.getInt("user_id"));
        r.setFullName(rs.getString("full_name"));
        r.setAddress(rs.getString("address"));
        r.setEmail(rs.getString("email"));
        r.setNic(rs.getString("nic"));
        r.setCheckIn(rs.getDate("check_in"));
        r.setCheckOut(rs.getDate("check_out"));
        r.setGuestCount(rs.getInt("guest_count"));
        r.setRoomType(rs.getString("room_type"));
        r.setFoodPackage(rs.getString("food_package"));
        r.setTotalAmount(rs.getDouble("total_amount"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}