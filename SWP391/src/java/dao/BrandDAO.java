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
}

