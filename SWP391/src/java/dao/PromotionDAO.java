/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Promotion;
import model.PromotionLaptop;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Admin
 */
public class PromotionDAO extends ConnectDB {

    public void createPromotion(Promotion promotion, ArrayList<PromotionLaptop> promotionLaptop) {
        String insertPromotion = "INSERT INTO Promotion (Title, Image, StartDate, EndDate) VALUES (?, ?, ?, ?)";
        try {
            connect.setAutoCommit(false);
            PreparedStatement pInsertPromotion = connect.prepareStatement(insertPromotion, Statement.RETURN_GENERATED_KEYS);
            Date startDate = new Date(promotion.getStartDate().getTime());
            Date endDate = new Date(promotion.getEndDate().getTime());
            pInsertPromotion.setString(1, promotion.getTitle());
            pInsertPromotion.setString(2, promotion.getImage());
            pInsertPromotion.setDate(3, startDate);
            pInsertPromotion.setDate(4, endDate);
            int check = pInsertPromotion.executeUpdate();
            int promotionId = 0;
            if (check > 0) {
                ResultSet rs = pInsertPromotion.getGeneratedKeys();
                if (rs.next()) {
                    promotionId = rs.getInt(1);
                }
            }
            String insertPromotionLaptop = "INSERT INTO PromotionProduct (PromotionID, LaptopID, DiscountPrice) VALUES (?, ?, ?)";
            PreparedStatement pInsertPromotionLaptop = connect.prepareStatement(insertPromotionLaptop);
            for (int i = 0; i < promotionLaptop.size(); i++) {
                pInsertPromotionLaptop.setInt(1, promotionId);
                pInsertPromotionLaptop.setInt(2, promotionLaptop.get(i).getLaptopId());
                pInsertPromotionLaptop.setBigDecimal(3, promotionLaptop.get(i).getDiscountPrice());
                pInsertPromotionLaptop.executeUpdate();
            }
            connect.commit();
        } catch (SQLException e) {
            try {
                connect.rollback();
            } catch (SQLException ex) {
                Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            e.printStackTrace();
        }
    }

    public ResultSet getListPromotion(String title, String status) {
        ResultSet rs = null;
        try {
            String prefixSql = "select p.ID, p.Image, p.Title, p.StartDate, p.EndDate, p.Status, Count(pp.ID) as NumberProduct from Promotion p "
                    + "inner join PromotionProduct pp on pp.PromotionID = p.ID ";
            String suffixSql = "group by p.ID, p.Image, p.Title, p.StartDate, p.EndDate, p.Status";
            if (title != null && !title.trim().isEmpty() && status == null) {
                prefixSql += "where p.Title like ? ";
            } else if (title == null && status != null && !status.trim().isEmpty()) {
                prefixSql += "where p.Status = ? ";
            } else if (title != null && !title.trim().isEmpty() && status != null && !status.trim().isEmpty()) {
                prefixSql += "where p.Title like ? and p.Status = ? ";
            }
            String sql = prefixSql + suffixSql;
            System.out.println(sql);
            System.out.println(title);
            System.out.println(status);
            PreparedStatement pre = connect.prepareStatement(sql);
            if (title != null && !title.trim().isEmpty() && status == null) {
                System.out.println("only title");
                pre.setString(1, "%" + title + "%");
            } else if (title == null && status != null && !status.trim().isEmpty()) {
                System.out.println("only status");
                pre.setString(1, status);
            } else if (title != null && !title.trim().isEmpty() && status != null && !status.trim().isEmpty()) {
                System.out.println("both");
                pre.setString(1, "%" + title + "%");
                pre.setString(2, status);
            }
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public JSONObject getDetailPromotionByAdmin(int promotionId) {
        JSONObject promotion = new JSONObject();
        try {
            String sql = "SELECT Title, Image, StartDate, EndDate, Status FROM Promotion WHERE ID = ?";
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, promotionId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                promotion.put("id", promotionId);
                promotion.put("title", rs.getString("Title"));
                promotion.put("image", rs.getString("Image"));
                promotion.put("startDate", rs.getString("StartDate"));
                promotion.put("endDate", rs.getString("EndDate"));
                promotion.put("status", rs.getString("Status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return promotion;
    }

    public JSONArray getListPromotionProductByAdmin(int promotionId) {
        JSONArray products = new JSONArray();
        try {
            String sql = "SELECT pp.ID, pp.LaptopID, l.LaptopName, pp.DiscountPrice, l.Price "
                    + "FROM PromotionProduct pp INNER JOIN Laptop l ON pp.LaptopID = l.LaptopID "
                    + "WHERE pp.PromotionID = ?";
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, promotionId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                JSONObject product = new JSONObject();
                product.put("laptopId", rs.getInt("LaptopID"));
                product.put("laptopName", rs.getString("LaptopName"));
                product.put("discountPrice", rs.getDouble("DiscountPrice"));
                product.put("price", rs.getDouble("Price"));
                products.put(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public void updatePromotion(Promotion promotion, ArrayList<PromotionLaptop> promotionLaptop) {
        String updatePromotion = "UPDATE Promotion SET Title = ?, Image = ?, StartDate = ?, EndDate = ? WHERE ID = ?";
        try {
            connect.setAutoCommit(false);
            PreparedStatement pUpdatePromotion = connect.prepareStatement(updatePromotion);
            Date startDate = new Date(promotion.getStartDate().getTime());
            Date endDate = new Date(promotion.getEndDate().getTime());
            pUpdatePromotion.setString(1, promotion.getTitle());
            pUpdatePromotion.setString(2, promotion.getImage());
            pUpdatePromotion.setDate(3, startDate);
            pUpdatePromotion.setDate(4, endDate);
            pUpdatePromotion.setInt(5, promotion.getId());
            pUpdatePromotion.executeUpdate();
            String insertPromotionLaptop = "INSERT INTO PromotionProduct (PromotionID, LaptopID, DiscountPrice) VALUES (?, ?, ?)";
            PreparedStatement pInsertPromotionLaptop = connect.prepareStatement(insertPromotionLaptop);
            for (int i = 0; i < promotionLaptop.size(); i++) {
                pInsertPromotionLaptop.setInt(1, promotion.getId());
                pInsertPromotionLaptop.setInt(2, promotionLaptop.get(i).getLaptopId());
                pInsertPromotionLaptop.setBigDecimal(3, promotionLaptop.get(i).getDiscountPrice());
                pInsertPromotionLaptop.executeUpdate();
            }
            connect.commit();
        } catch (Exception e) {
            try {
                connect.rollback();
            } catch (SQLException ex) {
                Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            e.printStackTrace();
        }
    }

    public void updatePromotionProduct(PromotionLaptop promotionLaptop) {
        try {
            String checkSql = "SELECT COUNT(*) FROM PromotionProduct WHERE PromotionID = ? AND LaptopID = ?";
            PreparedStatement pCheck = connect.prepareStatement(checkSql);
            pCheck.setInt(1, promotionLaptop.getPromotionId());
            pCheck.setInt(2, promotionLaptop.getLaptopId());
            ResultSet rs = pCheck.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            if (count > 0) {
                // Cập nhật DiscountPrice
                String updateSql = "UPDATE PromotionProduct SET DiscountPrice = ? WHERE PromotionID = ? AND LaptopID = ?";
                PreparedStatement preUpdate = connect.prepareStatement(updateSql);
                preUpdate.setBigDecimal(1, promotionLaptop.getDiscountPrice());
                preUpdate.setInt(2, promotionLaptop.getPromotionId());
                preUpdate.setInt(3, promotionLaptop.getLaptopId());
                preUpdate.executeUpdate();
            } else {
                // Thêm mới sản phẩm
                String insertSql = "INSERT INTO PromotionProduct (PromotionID, LaptopID, DiscountPrice) VALUES (?, ?, ?)";
                PreparedStatement preInsert = connect.prepareStatement(insertSql);
                preInsert.setInt(1, promotionLaptop.getPromotionId());
                preInsert.setInt(2, promotionLaptop.getLaptopId());
                preInsert.setBigDecimal(3, promotionLaptop.getDiscountPrice());
                preInsert.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePromotionProduct(int promotionId, int productId) {
        try {
            String sql = "DELETE FROM PromotionProduct WHERE PromotionID = ? AND LaptopID = ?";
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, promotionId);
            pre.setInt(2, productId);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deletePromotion(int promotionId, String status) {
        try {
            String sqlPromotion = "Update Promotion SET Status = ? WHERE ID = ?";
            PreparedStatement prePromotion = connect.prepareStatement(sqlPromotion);
            prePromotion.setString(1, status);
            prePromotion.setInt(2, promotionId);
            prePromotion.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
