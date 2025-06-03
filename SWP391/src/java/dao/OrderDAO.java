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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class OrderDAO extends ConnectDB {

    public void uppdateorder(Order od) {
        String sql = "INSERT INTO Orders\n"
                + "    (UserID, OrderDate, ShipFeeID, TotalAmount, Address, Note, PhoneNumber, StatusID, VoucherID, PaymentMethodID)\n"
                + "VALUES\n"
                + "    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, od.getUserID());
            st.setDate(2, java.sql.Date.valueOf(od.getOrderDate()));
            st.setInt(3, od.getShipfeeID());
            st.setBigDecimal(4, od.getTotalAmount());
            st.setNString(5, od.getAddress());
            st.setNString(6, od.getNote());
            st.setString(7, od.getPhoneNumber());
            st.setInt(8, od.getStatusID());
            st.setInt(9, od.getVoucherID());
            st.setInt(10, od.getPaymentmethodID());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("SQL error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public int GetLastOrderID(){
        String sql="SELECT MAX(OrderID) AS lastOrderID FROM Orders;";
        int id=0;
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                id=rs.getInt("lastOrderID");
            }
        }catch(SQLException e){
            e.printStackTrace();
    }
        return id;
}
}


