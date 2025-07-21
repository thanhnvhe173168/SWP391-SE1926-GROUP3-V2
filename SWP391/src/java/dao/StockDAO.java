/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Stock;

/**
 *
 * @author Admin
 */
public class StockDAO extends ConnectDB {

    public void createStock(Stock stock) {
        String sql = "Insert into Stock(LaptopID, UserID, Quantity, [Action]) values (?, ?, ?, ?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, stock.getLaptopId());
            pre.setInt(2, stock.getUserId());
            pre.setInt(3, stock.getQuantity());
            pre.setString(4, stock.getAction());
            pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ResultSet getListStockByLaptop(int laptopId) {
        ResultSet rs = null;
        String sql = "select s.ID, s.Quantity, s.[Date], s.[Action], l.LaptopName, u.FullName from Stock s "
                + "inner join Laptop l on s.LaptopID = l.LaptopID "
                + "inner join Users u on s.UserID = u.UserID "
                + "where s.LaptopID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, laptopId);
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
