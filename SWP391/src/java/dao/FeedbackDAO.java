/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.Feedback;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Laptop;
import model.OrderDetail;

/**
 *
 * @author linhd
 */
public class FeedbackDAO extends ConnectDB {

    //admin: view feedback list(sai)
    public List<Feedback> getFeedbackListWithPaging(int offset, int pageSize) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, s.StatusName "
                + "FROM Feedback f "
                + "JOIN Statuses s ON f.StatusID = s.StatusID "
                + "WHERE s.StatusType = N'Feedback' "
                + "ORDER BY f.FeedbackID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackID(rs.getInt("FeedbackID"));
                fb.setUserID(rs.getInt("UserID"));
                fb.setTitle(rs.getString("Title"));
                fb.setContent(rs.getString("Content"));
                fb.setRating(rs.getInt("Rating"));
                fb.setSellerRating(rs.getInt("SellerRating"));
                fb.setShippingRating(rs.getInt("ShippingRating"));
                fb.setImageURL(rs.getString("ImageURL"));
                fb.setCreatedAt(rs.getTimestamp("CreatedAt"));
                fb.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                fb.setStatusID(rs.getInt("StatusID"));
                fb.setReplyContent(rs.getString("ReplyContent"));
//                fb.setStatusName(rs.getString("StatusName"));

                list.add(fb);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public int getTotalFeedbackCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Feedback f \n"
                + "JOIN Statuses s ON f.StatusID = s.StatusID \n"
                + "WHERE s.StatusType = N'Feedback'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    //Lấy danh sách laptop đã mua và đủ điều kiện đánh giá
    public List<OrderDetail> getPurchasedLaptopsEligibleForFeedback(int userId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    od.OrderID, od.LaptopID, od.Quantity,od.UnitPrice,od.ReviewID,l.LaptopName,l.ImageURL\n"
                + "FROM \n"
                + "    Orders AS o\n"
                + "    JOIN OrderDetail AS od ON o.OrderID = od.OrderID\n"
                + "    INNER JOIN Laptop AS l ON od.LaptopID = l.LaptopID\n"
                + "WHERE \n"
                + "    o.UserID = ? \n"
                + "    AND od.ReviewID IS NULL\n"
                + "    AND o.StatusID IN (7, 9, 10, 13, 14)";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Laptop laptop = new Laptop();
                laptop.setLaptopID(rs.getInt("LaptopID"));
                laptop.setLaptopName(rs.getString("LaptopName"));
                laptop.setImageURL(rs.getString("ImageURL"));

                OrderDetail od = new OrderDetail();
                od.setOrderID(rs.getInt("OrderID"));
                od.setLaptop(laptop);
                od.setQuantity(rs.getInt("Quantity"));
                od.setUnitPrice(rs.getBigDecimal("UnitPrice"));

                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

//Give feedback    
    public boolean addFeedback(Feedback fb) {
        String sql = "INSERT INTO Feedback "
                + "(UserID, OrderID, LaptopID, Title, Content, Rating, SellerRating, ShippingRating, ImageURL, StatusID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, fb.getUserID());
            ps.setInt(2, fb.getOrderID());
            ps.setInt(3, fb.getLaptopID());
            ps.setString(4, fb.getTitle());
            ps.setString(5, fb.getContent());
            ps.setInt(6, fb.getRating());
            ps.setInt(7, fb.getSellerRating());
            ps.setInt(8, fb.getShippingRating());
            ps.setString(9, fb.getImageURL());
            ps.setInt(10, fb.getStatusID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteFeedback(int feedbackID, int userID) {
        String sql = "DELETE FROM Feedback WHERE FeedbackID=? AND UserID=? AND StatusID=28";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, feedbackID);
            ps.setInt(2, userID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//updateFeedback
    public Feedback getFeedbackByID(int id) {
        Feedback fb = null;
        String sql = "Select * from Feedback where FeedbackID=?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                fb = new Feedback();
                fb.setFeedbackID(rs.getInt("FeedbackID"));
                fb.setUserID(rs.getInt("UserID"));
                fb.setTitle(rs.getString("Title"));
                fb.setContent(rs.getString("Content"));
                fb.setRating(rs.getInt("Rating"));
                fb.setSellerRating(rs.getInt("SellerRating"));
                fb.setShippingRating(rs.getInt("ShippingRating"));
                fb.setImageURL(rs.getString("ImageURL"));
                fb.setStatusID(rs.getInt("StatusID"));
                fb.setCreatedAt(rs.getTimestamp("CreatedAt"));
                fb.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                fb.setReplyContent(rs.getString("ReplyContent"));
                return fb;

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return fb;
    }

    public int updateFeedback(int feedbackID, int userID, String title, String content, int rating, int sellerRating, int shippingRating) {
        int n = 0;
        String sql = "UPDATE Feedback SET Title=?, Content=?, Rating=?, SellerRating=?, ShippingRating=?, UpdatedAt=GETDATE() "
                + "WHERE FeedbackID=? AND UserID=?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, rating);
            ps.setInt(4, sellerRating);
            ps.setInt(5, shippingRating);
            ps.setInt(6, feedbackID);
            ps.setInt(7, userID);
            n = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }

    public void replyFeedback(int feedbackID, String replyContent) {
        String sql = "UPDATE Feedback SET ReplyContent = ?, StatusID = ? WHERE FeedbackID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, replyContent);
            ps.setInt(2, 2);//da phan hoi
            ps.setInt(3, feedbackID);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//view feedback in detail product   
    public List<Feedback> getFeedbackByProductID(int productId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE ProductID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackID(rs.getInt("FeedbackID"));
                fb.setUserID(rs.getInt("UserID"));
                fb.setTitle(rs.getString("Title"));
                fb.setContent(rs.getString("Content"));
                fb.setRating(rs.getInt("Rating"));
                fb.setCreatedAt(rs.getTimestamp("CreatedAt"));
                fb.setReplyContent(rs.getString("ReplyContent"));

                list.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
