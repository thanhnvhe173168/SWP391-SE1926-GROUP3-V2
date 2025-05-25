/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Category;

/**
 *
 * @author Admin
 */
public class CategoryDAO extends ConnectDB {

    public ResultSet getListCategory() {
        ResultSet rs = null;
        String sql = "Select * from Category";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public boolean checkExistCategoryName(String categoryName, int categoryId) {
        boolean check = false;
        ResultSet rs = null;
        String sql = categoryId != 0
                ? "Select * from Category where CategoryName = ? and CategoryID != ?"
                : "Select * from Category where CategoryName = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, categoryName);
            if (categoryId != 0) {
                pre.setInt(2, categoryId);
            }
            rs = pre.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return check;
    }

    public int createCategory(String categoryName) {
        int n = 0;
        String sql = "Insert into Category(CategoryName) values (?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, categoryName);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public Category getCategoryById(int categoryId) {
        ResultSet rs = null;
        String sql = "Select * from Category where CategoryID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, categoryId);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("CategoryID"), rs.getString("CategoryName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateCategory(int categoryId, String categoryName) {
        int n = 0;
        String sql = "Update Category set CategoryName = ? where CategoryID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, categoryName);
            pre.setInt(2, categoryId);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int deleteCategory(int categoryId) {
        int n = 0;
        String sql = "Delete from Category where CategoryID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, categoryId);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
}
