/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Laptop;

/**
 *
 * @author Window 11
 */
public class LaptopDAO extends ConnectDB {

    BrandDAO branddao = new BrandDAO();
    CategoryDAO categorydao = new CategoryDAO();
    CPUDAO cpudao = new CPUDAO();
    ScreenSizeDAO screendao = new ScreenSizeDAO();
    StatusDAO statusdao = new StatusDAO();

    public Laptop GetLaptop(int LaptopID) {
        Laptop laptop = new Laptop();
        String sql = "select * from Laptop where LaptopID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, LaptopID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                laptop.setBrand(branddao.getBrandById(rs.getInt("BrandID")));
                laptop.setCategory(categorydao.getCategoryById(rs.getInt("CategoryID")));
                laptop.setCpu(cpudao.GetCPU(rs.getInt("CPUID")));
                laptop.setDescription(rs.getString("Description"));
                laptop.setHardDrive(rs.getString("HardDrive"));
                laptop.setImageURL(rs.getString("ImageURL"));
                laptop.setLaptopID(LaptopID);
                laptop.setLaptopName(rs.getString("LaptopName"));
                laptop.setPrice(rs.getBigDecimal("Price"));
                laptop.setRam(rs.getString("Ram"));
                laptop.setScreen(screendao.GetScreen(rs.getInt("ScreenID")));
                laptop.setStatusID(statusdao.GetStatus(rs.getInt("StatusID")));
                laptop.setStock(rs.getInt("Stock"));
                laptop.setWarrantyPeriod(rs.getString("WarrantyPeriod"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return laptop;
    }
}
