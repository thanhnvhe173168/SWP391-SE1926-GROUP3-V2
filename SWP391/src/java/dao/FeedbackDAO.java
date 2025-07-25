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

//Give feedback    
    public boolean addFeedback(Feedback fb) {
      String sql = "INSERT INTO Feedback (UserID, OrderID, LaptopID, Title, Content, Rating, SellerRating, ShippingRating, ImageURL, StatusID, CreatedAt, UpdatedAt) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
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

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            return false;
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
                fb.setLaptopID(rs.getInt("LaptopID"));
                fb.setOrderID(rs.getInt("OrderID"));
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

                return fb;

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return fb;
    }

    public int updateFeedback(int feedbackID, int laptopID, int orderID, int userID,
            String title, String content, int rating, int sellerRating, int shippingRating) {
        int n = 0;
        String sql = "UPDATE Feedback SET Title=?, Content=?, Rating=?, SellerRating=?, ShippingRating=?, UpdatedAt=GETDATE() "
                + "WHERE FeedbackID=? AND UserID=? AND LaptopID=? AND OrderID=?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, rating);
            ps.setInt(4, sellerRating);
            ps.setInt(5, shippingRating);
            ps.setInt(6, feedbackID);
            ps.setInt(7, userID);
            ps.setInt(8, laptopID);
            ps.setInt(9, orderID);

            n = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }

//delete feedback
    public void deleteFeedbackByCustomer(int feedbackID, int userID, int laptopID, int orderID) {
        String sql = "DELETE FROM Feedback WHERE FeedbackID=? AND UserID=? AND LaptopID=? AND OrderID=?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, feedbackID);
            ps.setInt(2, userID);
            ps.setInt(3, laptopID);
            ps.setInt(4, orderID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void deleteFeedbackByAdmin(int feedbackID) {
    String sql = "DELETE FROM Feedback WHERE FeedbackID=?";
    try {
        PreparedStatement ps = connect.prepareStatement(sql);
    
        ps.setInt(1, feedbackID);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
//view feedback in Productdetail
    public List<Feedback> getFeedbackByLaptopID(int laptopId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.FeedbackID, f.LaptopID, f.OrderID, f.UserID, f.Title, f.Content, f.Rating,\n"
                + "                        f.SellerRating, f.ShippingRating, f.ImageURL, f.CreatedAt, f.UpdatedAt,\n"
                + "                        f.StatusID\n"
                + "                        \n"
                + "                 FROM Feedback f\n"
                + "                 JOIN Users u ON f.UserID = u.UserID\n"
                + "                 WHERE f.LaptopID = ?\n"
                + "                 ORDER BY f.CreatedAt DESC";

        try {
            PreparedStatement ps = connect.prepareStatement(sql);

            ps.setInt(1, laptopId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback fb = new Feedback();
                    fb.setFeedbackID(rs.getInt("FeedbackID"));
                    fb.setLaptopID(rs.getInt("LaptopID"));
                    fb.setOrderID(rs.getInt("OrderID"));
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
                    list.add(fb);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //admin: view feedback list
    public List<Feedback> getFeedbackListWithPaging(int offset, int pageSize) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, s.StatusName\n"
                + "FROM Feedback f\n"
                + "JOIN Statuses s ON f.StatusID = s.StatusID\n"
                + "ORDER BY f.FeedbackID DESC\n"
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
                fb.setLaptopID(rs.getInt("LaptopID"));
                fb.setTitle(rs.getString("Title"));
                fb.setContent(rs.getString("Content"));
                fb.setRating(rs.getInt("Rating"));
                fb.setSellerRating(rs.getInt("SellerRating"));
                fb.setShippingRating(rs.getInt("ShippingRating"));
                fb.setImageURL(rs.getString("ImageURL"));
                fb.setCreatedAt(rs.getTimestamp("CreatedAt"));
                fb.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                fb.setStatusID(rs.getInt("StatusID"));

                list.add(fb);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalFeedbackCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) "
                + "FROM Feedback f "
                + "JOIN Statuses s ON f.StatusID = s.StatusID "
                + "WHERE s.StatusType = N'Feedback'";

        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getTotalFeedbackCount: " + e.getMessage());
        }

        return count;
    }

//admin: feedbackDetail
    public Feedback getFeedbackByIDForDetail(int FeedbackID) {
        Feedback fb = null;
        String sql = " SELECT f.FeedbackID, f.LaptopID, f.OrderID, f.Title, f.Content, f.Rating, \n"
                + "	f.SellerRating, f.ShippingRating, f.CreatedAt, f.UpdatedAt\n"
                + "        FROM Feedback f\n"
                + "        JOIN Users u ON f.UserID = u.UserID\n"
                + "        WHERE f.FeedbackID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, FeedbackID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                fb = new Feedback();
                fb.setFeedbackID(rs.getInt("FeedbackID"));
                fb.setLaptopID(rs.getInt("LaptopID"));
                fb.setOrderID(rs.getInt("OrderID"));
                fb.setTitle(rs.getString("Title"));
                fb.setContent(rs.getString("Content"));
                fb.setRating(rs.getInt("Rating"));
                fb.setSellerRating(rs.getInt("SellerRating"));
                fb.setShippingRating(rs.getInt("ShippingRating"));
                fb.setCreatedAt(rs.getTimestamp("CreatedAt"));
                fb.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fb;
    }
}
