package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.WishList;

public class WishListDAO extends ConnectDB {

    public boolean addToWishList(int userId, int laptopId) {
        String checkSql = "SELECT COUNT(*) FROM Wishlist WHERE UserID = ? AND LaptopID = ?";
        String insertSql = "INSERT INTO Wishlist (UserID, LaptopID) VALUES (?, ?)";

        try {
            PreparedStatement ps = connect.prepareStatement(checkSql);
            ps.setInt(1, userId);
            ps.setInt(2, laptopId);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count == 0) {
                PreparedStatement insertStmt = connect.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, laptopId);
                insertStmt.executeUpdate();
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public ResultSet getWishlistByUserId(int userId) {
        String sql = "SELECT w.WishlistID, w.LaptopID, l.LaptopName, l.Price, l.ImageURL " +
                     "FROM Wishlist w JOIN Laptop l ON w.LaptopID = l.LaptopID " +
                     "WHERE w.UserID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}