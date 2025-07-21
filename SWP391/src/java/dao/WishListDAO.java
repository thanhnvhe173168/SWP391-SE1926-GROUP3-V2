package dao;

import config.ConnectDB;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Laptop;
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
//view List WishList

    public List<WishList> getWishlistByUserIdWithPaging(int userId, int offset, int pageSize) {
        List<WishList> list = new ArrayList<>();
        String sql = "SELECT w.WishlistID, w.UserID, w.LaptopID, "
                + "l.LaptopName, l.Price, l.ImageURL "
                + "FROM Wishlist w "
                + "JOIN Laptop l ON w.LaptopID = l.LaptopID "
                + "WHERE w.UserID = ? "
                + "ORDER BY w.WishlistID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WishList wishList = new WishList();
                wishList.setWishlistId(rs.getInt("WishlistId"));
                wishList.setUserId(rs.getInt("UserId"));
                wishList.setLaptopId(rs.getInt("LaptopId"));

                Laptop laptop = new Laptop();
                laptop.setLaptopID(rs.getInt("LaptopID"));
                laptop.setLaptopName(rs.getString("LaptopName"));
                laptop.setPrice(rs.getBigDecimal("Price"));
                laptop.setImageURL(rs.getString("ImageURL"));

                wishList.setLaptop(laptop); 

                list.add(wishList);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalWishListCount(int userID) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Wishlist WHERE UserID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int removeWishList(int wishlistID) throws SQLException {
        int n = 0;
        String sql = "DELETE FROM WishList WHERE WishlistID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, wishlistID);
            n = ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }

    public boolean addToCartFromWishlist(int userId, int wishlistId) {
        String getLaptopSql = "SELECT LaptopID FROM Wishlist WHERE WishlistID = ?";
        String checkCartSql = "SELECT CartID FROM Cart WHERE UserID = ?";
        String checkDetailSql = "SELECT Quantity FROM CartDetail WHERE CartID = ? AND LaptopID = ?";
        String insertCartSql = "INSERT INTO Cart (UserID) VALUES (?)";
        String insertDetailSql = "INSERT INTO CartDetail (CartID, LaptopID, Quantity, UnitPrice, is_selected) VALUES (?, ?, 1, ?, 0)";
        String updateDetailSql = "UPDATE CartDetail SET Quantity = Quantity + 1 WHERE CartID = ? AND LaptopID = ?";

        try {
            // Lấy LaptopID từ Wishlist
            int laptopId = -1;
            PreparedStatement psGetLaptop = connect.prepareStatement(getLaptopSql);
            psGetLaptop.setInt(1, wishlistId);
            ResultSet rsLaptop = psGetLaptop.executeQuery();
            if (rsLaptop.next()) {
                laptopId = rsLaptop.getInt("LaptopID");
            } else {
                System.out.println("WishlistID " + wishlistId + " không tồn tại!");
                return false;
            }

            // Lấy hoặc tạo CartID
            int cartId = -1;
            PreparedStatement psCheckCart = connect.prepareStatement(checkCartSql);
            psCheckCart.setInt(1, userId);
            ResultSet rsCart = psCheckCart.executeQuery();
            if (rsCart.next()) {
                cartId = rsCart.getInt("CartID");
            } else {
                PreparedStatement psInsertCart = connect.prepareStatement(insertCartSql);
                psInsertCart.setInt(1, userId);
                psInsertCart.executeUpdate();
                ResultSet rsNewCart = psInsertCart.getGeneratedKeys();
                if (rsNewCart.next()) {
                    cartId = rsNewCart.getInt(1);
                    System.out.println("Tạo mới CartID: " + cartId + " cho UserID: " + userId);
                }
            }

            if (cartId == -1) {
                System.out.println("Không thể tạo hoặc lấy CartID cho UserID: " + userId);
                return false;
            }

            // Lấy giá sản phẩm từ Laptop
            LaptopDAO lapDao = new LaptopDAO();
            Laptop laptop = lapDao.getLaptopById(laptopId);
            BigDecimal unitPrice = laptop.getPrice();
            if (unitPrice == null) {
                System.out.println("Không lấy được giá cho LaptopID: " + laptopId);
                return false;
            }

            // Kiểm tra và thêm hoặc cập nhật CartDetail
            PreparedStatement psCheckDetail = connect.prepareStatement(checkDetailSql);
            psCheckDetail.setInt(1, cartId);
            psCheckDetail.setInt(2, laptopId);
            ResultSet rsDetail = psCheckDetail.executeQuery();
            if (rsDetail.next()) {
                PreparedStatement psUpdate = connect.prepareStatement(updateDetailSql);
                psUpdate.setInt(1, cartId);
                psUpdate.setInt(2, laptopId);
                psUpdate.executeUpdate();
                System.out.println("Cập nhật số lượng cho CartID: " + cartId + ", LaptopID: " + laptopId);
                return false;
            } else {
                PreparedStatement psInsertDetail = connect.prepareStatement(insertDetailSql);
                psInsertDetail.setInt(1, cartId);
                psInsertDetail.setInt(2, laptopId);
                psInsertDetail.setBigDecimal(3, unitPrice);
                psInsertDetail.executeUpdate();
                System.out.println("Thêm mới vào CartDetail: CartID: " + cartId + ", LaptopID: " + laptopId + ", UnitPrice: " + unitPrice);
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi SQL: " + e.getMessage());
            return false;
        }
    }
}
