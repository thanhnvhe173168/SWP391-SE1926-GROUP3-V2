/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Brand;

/**
 *
 * @author Admin
 */
public class BrandDAO1 extends ConnectDB {

    public ResultSet getListBrand() {
        ResultSet rs = null;
        String sql = "Select * from Brand";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public boolean checkExistBrandName(String brandName, int brandId) {
        boolean check = false;
        ResultSet rs = null;
        String sql = brandId != 0
                ? "Select * from Brand where BrandName = ? and BrandID != ?"
                : "Select * from Brand where BrandName = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, brandName);
            if (brandId != 0) {
                pre.setInt(2, brandId);
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

    public int createBrand(String brandName) {
        int n = 0;
        String sql = "Insert into Brand(BrandName) values (?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, brandName);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public Brand getBrandById(int brandId) {
        ResultSet rs = null;
        String sql = "Select * from Brand where BrandID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, brandId);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new Brand(rs.getInt("BrandID"), rs.getString("BrandName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateBrand(int brandId, String brandName) {
        int n = 0;
        String sql = "Update Brand set BrandName = ? where BrandID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, brandName);
            pre.setInt(2, brandId);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int deleteBrand(int brandId) {
        int n = 0;
        String sql = "Delete from Brand where BrandID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, brandId);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    
    
}
