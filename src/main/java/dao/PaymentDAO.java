package dao;

import model.Payment;
import model.PaymentMethod;
import model.PaymentStatus;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO payments (reservation_id, amount, payment_method, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, payment.getReservationId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getPaymentMethod().name());
            ps.setString(4, payment.getStatus().name());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) payment.setPaymentId(rs.getInt(1));
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Payment> getAllPayments() {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT p.*, r.full_name, r.reservation_no FROM payments p " +
                     "LEFT JOIN reservations r ON p.reservation_id = r.reservation_id " +
                     "ORDER BY p.payment_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRowWithReservation(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Payment> searchPayments(String query, String status, String startDate, String endDate) {
        List<Payment> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, r.full_name, r.reservation_no, r.check_in, r.check_out FROM payments p " +
            "LEFT JOIN reservations r ON p.reservation_id = r.reservation_id WHERE 1=1 ");
        
        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (r.full_name LIKE ? OR r.reservation_no LIKE ? OR p.payment_id = ?) ");
        }
        if (status != null && !status.isEmpty() && !"ALL".equals(status)) {
            sql.append("AND p.status = ? ");
        }
        if (startDate != null && !startDate.isEmpty()) {
            sql.append("AND r.check_in >= ? ");
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append("AND r.check_out <= ? ");
        }
        sql.append("ORDER BY p.payment_date DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIdx = 1;
            if (query != null && !query.trim().isEmpty()) {
                String q = "%" + query + "%";
                ps.setString(paramIdx++, q);
                ps.setString(paramIdx++, q);
                try { ps.setInt(paramIdx++, Integer.parseInt(query)); } catch (Exception e) { ps.setInt(paramIdx-1, -1); }
            }
            if (status != null && !status.isEmpty() && !"ALL".equals(status)) {
                ps.setString(paramIdx++, status);
            }
            if (startDate != null && !startDate.isEmpty()) {
                try { ps.setDate(paramIdx++, java.sql.Date.valueOf(startDate)); } catch(Exception e) { ps.setNull(paramIdx-1, java.sql.Types.DATE); }
            }
            if (endDate != null && !endDate.isEmpty()) {
                try { ps.setDate(paramIdx++, java.sql.Date.valueOf(endDate)); } catch(Exception e) { ps.setNull(paramIdx-1, java.sql.Types.DATE); }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowWithReservation(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Payment mapRowWithReservation(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setPaymentId(rs.getInt("payment_id"));
        p.setReservationId(rs.getInt("reservation_id"));
        p.setAmount(rs.getDouble("amount"));
        p.setPaymentDate(rs.getTimestamp("payment_date"));
        
        try {
            p.setPaymentMethod(PaymentMethod.valueOf(rs.getString("payment_method")));
        } catch (Exception e) { p.setPaymentMethod(PaymentMethod.CASH); }
        
        try {
            p.setStatus(PaymentStatus.valueOf(rs.getString("status")));
        } catch (Exception e) { p.setStatus(PaymentStatus.PENDING); }
        
        model.Reservation res = new model.Reservation();
        String fullName = rs.getString("full_name");
        res.setFullName(fullName != null ? fullName : "Unknown Guest");
        
        String resNo = rs.getString("reservation_no");
        res.setReservationNo(resNo != null ? resNo : "N/A");
        
        try { res.setCheckIn(rs.getDate("check_in")); } catch (Exception e) {}
        try { res.setCheckOut(rs.getDate("check_out")); } catch (Exception e) {}
        p.setReservation(res);
        
        return p;
    }
}