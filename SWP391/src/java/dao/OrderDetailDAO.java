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
import java.util.List;

/**
 *
 * @author Window 11
 */
public class OrderDetailDAO extends ConnectDB {
    ReviewDAO rdao = new ReviewDAO();
    LaptopDAO ldao = new LaptopDAO();

    public void addorderdetail(OrderDetail ord) {
        String sql = "INSERT INTO OrderDetail (OrderID, LaptopID, Quantity, UnitPrice, ReviewID) "
                + "VALUES (?, ?, ?, ?, ?);";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, ord.getOrderID());
            st.setInt(2, ord.getLaptop().getLaptopID());
            st.setInt(3, ord.getQuantity());
            st.setBigDecimal(4, ord.getUnitPrice());

            // Kiểm tra xem review có null không
            if (ord.getReview() == null) {
                st.setNull(5, java.sql.Types.INTEGER);
            } else {
                st.setInt(5, ord.getReview().getReviewID());
            }

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderDetail> GetListOrderDetailByID(int id) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "select * from OrderDetail where OrderID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderID(id);
                od.setLaptop(ldao.GetLaptop(rs.getInt("laptopid")));
                od.setQuantity(rs.getInt("quantity"));
                od.setUnitPrice(rs.getBigDecimal("unitprice"));
                od.setReview(rdao.getReviewByID(rs.getInt("ReviewID")));
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
