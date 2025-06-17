/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Laptop;

/**
 *
 * @author Window 11
 */
public class LaptopDAO extends ConnectDB {

    public Laptop getLaptopById(int LaptopID) {
        Laptop laptop = new Laptop();
        String sql = "select * from Laptop where LaptopID = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, LaptopID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                laptop.setBrand(rs.getInt("BrandID"));
                laptop.setCategory(rs.getInt("CategoryID"));
                laptop.setCpu(rs.getInt("CPUID"));
                laptop.setDescription(rs.getString("Description"));
                laptop.setHardDrive(rs.getString("HardDrive"));
                laptop.setImageURL(rs.getString("ImageURL"));
                laptop.setLaptopID(LaptopID);
                laptop.setLaptopName(rs.getString("LaptopName"));
                laptop.setPrice(rs.getBigDecimal("Price"));
                laptop.setRam(rs.getString("Ram"));
                laptop.setScreen(rs.getInt("ScreenID"));
                laptop.setStatus(rs.getInt("StatusID"));
                laptop.setStock(rs.getInt("Stock"));
                laptop.setWarrantyPeriod(rs.getString("WarrantyPeriod"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return laptop;
    }

    public ResultSet getListLaptop(int currentPage, int pageSize, String laptopName, int brandId, int categoryId, int cpuId, int screenId, int statusId) {
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder(
                "select l.LaptopID, l.LaptopName, l.Price, l.ImageURL, l.HardDrive, l.WarrantyPeriod, c.CPUInfo, s.Size, l.RAM, l.Stock from Laptop l "
                + "inner join CPU c on l.CPUID = c.CPUID "
                + "inner join ScreenSize s on s.ScreenID = l.ScreenID "
        );
        ArrayList<Object> parameter = new ArrayList<>();
        if (statusId != 0) {
            sql.append(" where l.StatusID = ?");
            parameter.add(statusId);
        } else {
            sql.append(" where l.StatusID != ?");
            parameter.add(0);
        }
        if (laptopName != null && !laptopName.trim().isEmpty()) {
            sql.append(" and l.LaptopName like ?");
            parameter.add("%" + laptopName + "%");
        }
        if (brandId != 0) {
            sql.append(" and l.BrandID = ?");
            parameter.add(brandId);
        }
        if (categoryId != 0) {
            sql.append(" and l.CategoryID = ?");
            parameter.add(categoryId);
        }
        if (cpuId != 0) {
            sql.append(" and l.CPUID = ?");
            parameter.add(cpuId);
        }
        if (screenId != 0) {
            sql.append(" and l.ScreenID = ?");
            parameter.add(screenId);
        }
        sql.append(" order by l.LaptopID offset ? rows fetch next ? rows only");
        parameter.add((currentPage - 1) * pageSize);
        parameter.add(pageSize);
        System.out.println(sql);
        System.out.println(parameter);
        try {
            PreparedStatement pre = connect.prepareStatement(sql.toString());
            for (int i = 0; i < parameter.size(); i++) {
                pre.setObject(i + 1, parameter.get(i));
            }
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public int getTotalRecord(String laptopName, int brandId, int categoryId, int cpuId, int screenId, int statusId) {
        int n = 0;
        StringBuilder sql = new StringBuilder(
                "select l.LaptopID, l.LaptopName, l.Price, l.ImageURL, l.HardDrive, l.WarrantyPeriod, c.CPUInfo, s.Size, l.RAM, l.Stock from Laptop l "
                + "inner join CPU c on l.CPUID = c.CPUID "
                + "inner join ScreenSize s on s.ScreenID = l.ScreenID"
        );
        ArrayList<Object> parameter = new ArrayList<>();
        if (statusId != 0) {
            sql.append(" where l.StatusID = ?");
            parameter.add(statusId);
        } else {
            sql.append(" where l.StatusID != ?");
            parameter.add(0);
        }
        if (laptopName != null && !laptopName.trim().isEmpty()) {
            sql.append(" and l.LaptopName like ?");
            parameter.add("%" + laptopName + "%");
        }
        if (brandId != 0) {
            sql.append(" and l.BrandID = ?");
            parameter.add(brandId);
        }
        if (categoryId != 0) {
            sql.append(" and l.CategoryID = ?");
            parameter.add(categoryId);
        }
        if (cpuId != 0) {
            sql.append(" and l.CPUID = ?");
            parameter.add(cpuId);
        }
        if (screenId != 0) {
            sql.append(" and l.ScreenID = ?");
            parameter.add(screenId);
        }
        try {
            PreparedStatement pre = connect.prepareStatement(sql.toString());
            for (int i = 0; i < parameter.size(); i++) {
                pre.setObject(i + 1, parameter.get(i));
            }
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                n++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
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
            pre.setInt(7, laptop.getStatus());
            pre.setString(8, laptop.getWarrantyPeriod());
            pre.setInt(9, laptop.getCpu());
            pre.setInt(10, laptop.getScreen());
            pre.setString(11, laptop.getRam());
            pre.setInt(12, laptop.getBrand());
            pre.setInt(13, laptop.getCategory());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }


    public void updateLaptopStock(int id, int quantity) {
        String sql = "UPDATE Laptop SET stock = ? WHERE LaptopID = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
            

    public int updateLaptop(Laptop laptop) {
        int n = 0;
        String sql = "Update Laptop set LaptopName = ?, Price = ?, Stock = ?, Description = ?, ImageURL = ?, "
                + "HardDrive = ?, StatusID = ?, WarrantyPeriod = ?, CPUID = ?, "
                + "ScreenID = ?, RAM = ?, BrandID = ?, CategoryID = ? where LaptopID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, laptop.getLaptopName());
            pre.setBigDecimal(2, laptop.getPrice());
            pre.setInt(3, laptop.getStock());
            pre.setString(4, laptop.getDescription());
            pre.setString(5, laptop.getImageURL());
            pre.setString(6, laptop.getHardDrive());
            pre.setInt(7, laptop.getStatus());
            pre.setString(8, laptop.getWarrantyPeriod());
            pre.setInt(9, laptop.getCpu());
            pre.setInt(10, laptop.getScreen());
            pre.setString(11, laptop.getRam());
            pre.setInt(12, laptop.getBrand());
            pre.setInt(13, laptop.getCategory());
            pre.setInt(14, laptop.getLaptopID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public void deleteLaptop(int id) {
        String sql = "Delete from Laptop where LaptopID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, id);
            pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
