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
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class OrderDetailDAO extends ConnectDB {

    ReviewDAO rdao = new ReviewDAO();
    LaptopDAO ldao = new LaptopDAO();
    StatusDAO sdao = new StatusDAO();

    public void addorderdetail(OrderDetail ord) {
        String sql = "INSERT INTO OrderDetail (OrderID, LaptopID, Quantity, UnitPrice, ReviewID, OrderDetailStatusID, ReasonReturn, ReturnDate, is_select) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, ord.getOrderID());
            st.setInt(2, ord.getLaptop().getLaptopID());
            st.setInt(3, ord.getQuantity());
            st.setBigDecimal(4, ord.getUnitPrice());

            if (ord.getReview() == null) {
                st.setNull(5, java.sql.Types.INTEGER);
            } else {
                st.setInt(5, ord.getReview().getReviewID());
            }

            st.setInt(6, ord.getOrderDetailStatus().getStatusID());

            if (ord.getReasonReturn() == null) {
                st.setNull(7, java.sql.Types.NVARCHAR);
            } else {
                st.setNString(7, ord.getReasonReturn());
            }

            if (ord.getReturnDate() == null) {
                st.setNull(8, java.sql.Types.DATE);
            } else {
                st.setDate(8, java.sql.Date.valueOf(ord.getReturnDate()));
            }
                st.setBoolean(9, ord.isIsSelect());
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

                // LaptopID - không null
                od.setLaptop(ldao.getLaptopById(rs.getInt("LaptopID")));

                // Quantity, UnitPrice - không null
                od.setQuantity(rs.getInt("Quantity"));
                od.setUnitPrice(rs.getBigDecimal("UnitPrice"));

                // ReviewID - có thể null
                int reviewId = rs.getInt("ReviewID");
                if (!rs.wasNull()) {
                    od.setReview(rdao.getReviewByID(reviewId));
                } else {
                    od.setReview(null);
                }

                // OrderDetailStatusID - không null
                od.setOrderDetailStatus(sdao.GetStatus(rs.getInt("OrderDetailStatusID")));

                // ReturnDate - có thể null
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }

                // ReasonReturn - có thể null
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
                od.setIsSelect(rs.getBoolean("is_select"));
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void upDateOrderDetailStatuswhenreturn(int statusid, int orderid, int laptopid) {
        String sql = "update OrderDetail\n"
                + "set OrderDetailStatusID=?\n"
                + "where OrderID=?\n"
                + "and LaptopID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid);
            st.setInt(2, orderid);
            st.setInt(3, laptopid);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void upDateOrderDetailStatuswhencancel(int statusid, int orderid) {
        String sql = "update OrderDetail\n"
                + "set OrderDetailStatusID=?\n"
                + "where OrderID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid);
            st.setInt(2, orderid);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
