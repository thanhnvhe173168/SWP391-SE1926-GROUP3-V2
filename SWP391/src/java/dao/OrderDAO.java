/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class OrderDAO extends ConnectDB {

    FeeShipDAO fsdao = new FeeShipDAO();
    VoucherDAO voudao = new VoucherDAO();
    StatusDAO sdao = new StatusDAO();
    PaymentMethodDAO pmdao = new PaymentMethodDAO();

    public void uppdateorder(Order od) {
        String sql = "INSERT INTO Orders (\n"
                + "    UserID, OrderDate, ShipFeeID, TotalAmount, Address,\n"
                + "    Note, PhoneNumber, StatusID, VoucherID,\n"
                + "    PaymentMethodID, PaymentDate, PaymentStatusID\n"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, od.getUserID());
            st.setDate(2, java.sql.Date.valueOf(od.getOrderDate()));
            st.setInt(3, od.getShipfee().getFeeShipID());
            st.setBigDecimal(4, od.getTotalAmount());
            st.setNString(5, od.getAddress());
            st.setNString(6, od.getNote());
            st.setString(7, od.getPhoneNumber());
            st.setInt(8, od.getOrderstatus().getStatusID());
            st.setInt(9, od.getVoucher().getVoucherID());
            st.setInt(10, od.getPaymentmethod().getPaymentMethodID());
            if (od.getPaymentdate() != null) {
                st.setDate(11, java.sql.Date.valueOf(od.getPaymentdate()));
            } else {
                st.setNull(11, java.sql.Types.DATE);
            }
            st.setInt(12, od.getPaymentstatus().getStatusID());
            st.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int GetLastOrderID() {
        String sql = "SELECT MAX(OrderID) AS lastOrderID FROM Orders;";
        int id = 0;
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt("lastOrderID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    public List<Order> getListOrder() {
        String sql = "select * from Orders";
        List<Order> orderlist = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            Order od = new Order();
            while (rs.next()) {
                od.setAddress(rs.getNString("Address"));
                od.setNote(rs.getNString("note"));
                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));
                od.setPhoneNumber(rs.getString("PhoneNumber"));
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));
                od.setVoucher(voudao.GetVoucherByID(rs.getInt("voucherID")));
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                od.setPaymentdate(rs.getDate("PaymentDate").toLocalDate());
                orderlist.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderlist;
    }
}
