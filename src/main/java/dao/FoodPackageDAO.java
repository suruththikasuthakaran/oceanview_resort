package dao;

import model.FoodPackage;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodPackageDAO {

    public boolean addFoodPackage(FoodPackage food) {
        String sql = "INSERT INTO food_packages (name, price, description, image) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, food.getName());
            ps.setDouble(2, food.getPrice());
            ps.setString(3, food.getDescription());
            ps.setString(4, food.getImage());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<FoodPackage> getAllFoodPackages() {
        List<FoodPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM food_packages";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToFoodPackage(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public FoodPackage getFoodPackageById(int packageId) {
        String sql = "SELECT * FROM food_packages WHERE package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFoodPackage(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateFoodPackage(FoodPackage food) {
        String sql = "UPDATE food_packages SET name = ?, price = ?, description = ?, image = ? WHERE package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, food.getName());
            ps.setDouble(2, food.getPrice());
            ps.setString(3, food.getDescription());
            ps.setString(4, food.getImage());
            ps.setInt(5, food.getPackageId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteFoodPackage(int packageId) {
        String sql = "DELETE FROM food_packages WHERE package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, packageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<FoodPackage> searchFoodPackages(String query) {
        List<FoodPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM food_packages WHERE name LIKE ? OR description LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchTerm = "%" + query + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToFoodPackage(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private FoodPackage mapResultSetToFoodPackage(ResultSet rs) throws SQLException {
        FoodPackage food = new FoodPackage();
        food.setPackageId(rs.getInt("package_id"));
        food.setName(rs.getString("name"));
        food.setPrice(rs.getDouble("price"));
        food.setDescription(rs.getString("description"));
        food.setImage(rs.getString("image"));
        return food;
    }
}