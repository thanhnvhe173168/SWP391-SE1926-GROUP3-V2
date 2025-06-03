/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.math.BigDecimal;
import model.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class OrderDetailDAO extends ConnectDB {

    public void addorderdetail(OrderDetail ord) {
        String sql = "INSERT INTO OrderDetail (OrderID, LaptopID, Quantity, UnitPrice)\n"
                + "VALUES (?, ?, ?, ?);";
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setInt(1, ord.getOrderID());
            st.setInt(2, ord.getLaptopID());
            st.setInt(3, ord.getQuantity());
            st.setBigDecimal(4, ord.getUnitPrice());
            st.executeUpdate();
        }
        catch(SQLException e){
            e.printStackTrace();
            System.out.println("SQL error: " + e.getMessage());
        }
    }
}
