/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import config.ConnectDB;
import model.Brand;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Window 11
 */
public class BrandDAO extends ConnectDB{
    public List<Brand> AllBrand(){
    List<Brand> list = new ArrayList<>();
        String sql = "select * from Brand";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Brand b = new Brand();
                b.setBrandID(rs.getInt("BrandID"));
                b.setBrandName(rs.getString("BrandName"));
                list.add(b);
                }
            }
        catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
}
    
    public Brand GetBrand(int brandid){
        Brand b = new Brand();
        String sql = "select * from Brand where BrandID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, brandid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                
                b.setBrandID(brandid);
                b.setBrandName(rs.getString("BrandName"));
                }
            }
        catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return b;
}
    
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

