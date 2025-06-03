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
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return laptop;
    }

    public ResultSet getListLaptop() {
        ResultSet rs = null;
        String sql = "select l.LaptopID, l.LaptopName, l.Price, \n"
                + "l.ImageURL, l.HardDrive, l.WarrantyPeriod, c.CPUInfo, \n"
                + "s.Size, l.RAM, l.Stock from Laptop l \n"
                + "inner join CPU c on l.CPUID = c.CPUID\n"
                + "inner join ScreenSize s on s.ScreenID = l.ScreenID";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public boolean checkExistLaptopName(String laptopName, int laptopId) {
        boolean check = false;
        ResultSet rs = null;
        String sql = laptopId != 0
                ? "Select * from Laptop where LaptopName = ? and LaptopID != ?"
                : "Select * from Laptop where LaptopName = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, laptopName);
            if (laptopId != 0) {
                pre.setInt(2, laptopId);
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

    public int createLaptop(Laptop laptop) {
        int n = 0;
        String sql = "Insert into Laptop(LaptopName, Price, Stock, Description, ImageURL, HardDrive, StatusID, WarrantyPeriod, CPUID, "
                + "ScreenID, RAM, BrandID, CategoryID) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, laptop.getLaptopName());
            pre.setBigDecimal(2, laptop.getPrice());
            pre.setInt(3, laptop.getStock());
            pre.setString(4, laptop.getDescription());
            pre.setString(5, laptop.getImageURL());
            pre.setString(6, laptop.getHardDrive());
            pre.setInt(7, laptop.getStatus().getStatusID());
            pre.setString(8, laptop.getWarrantyPeriod());
            pre.setInt(9, laptop.getCpu().getCpuID());
            pre.setInt(10, laptop.getScreen().getScreenID());
            pre.setString(11, laptop.getRam());
            pre.setInt(12, laptop.getBrand().getBrandID());
            pre.setInt(13, laptop.getCategory().getCategoryID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
}
