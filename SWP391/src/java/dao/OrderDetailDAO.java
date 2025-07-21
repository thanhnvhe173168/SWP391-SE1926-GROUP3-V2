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
import java.time.LocalDate;
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
        String sql = "INSERT INTO OrderDetail (OrderID, LaptopID, Quantity, UnitPrice, ReviewID, OrderDetailStatusID, ReasonReturn, ReturnDate, is_select, ImageReturn) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
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

            if (ord.getImageReturn() == null) {
                st.setNull(10, java.sql.Types.NVARCHAR);
            } else {
                st.setNString(10, ord.getImageReturn());
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

                String imageReturn = rs.getNString("ImageReturn");
                od.setImageReturn(imageReturn != null ? imageReturn : null);
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

    public void upDateOrderDetailStatusByAdmin(int statusid, int orderid) {
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

    public OrderDetail getOrderDetailByLapID(int id, int orderid) {
        String sql = "select * from OrderDetail\n"
                + "where LaptopID=?\n"
                + "and OrderID=?";
        OrderDetail od = new OrderDetail();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, orderid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
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

                String imageReturn = rs.getNString("ImageReturn");
                od.setImageReturn(imageReturn != null ? imageReturn : null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return od;
    }

    public void updateReasonReturn(int orderid, int lapid, String reason, LocalDate returndate) {
        String sql = "update OrderDetail\n"
                + "set ReasonReturn=?,\n"
                + "    ReturnDate=?\n"
                + "where OrderID=?\n"
                + "and LaptopID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, reason);
            st.setInt(3, orderid);
            st.setInt(4, lapid);
            st.setDate(2, java.sql.Date.valueOf(returndate));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateImageReturn(int orderid, int lapid, String image) {
        String sql = "update OrderDetail\n"
                + "set ImageReturn=?\n"
                + "where LaptopID=?\n"
                + "and OrderID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, image);
            st.setInt(2, lapid);
            st.setInt(3, orderid);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public List<OrderDetail> getOrderDetailByStatus(int id, int statusid) {
        String sql = "select * from OrderDetail\n"
                + "where OrderID=?\n"
                + "and OrderDetailStatusID=?";
        List<OrderDetail> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, statusid);
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

                String imageReturn = rs.getNString("ImageReturn");
                od.setImageReturn(imageReturn != null ? imageReturn : null);

                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Linh:Lấy danh sách laptop đã mua và cần đánh giá
    public List<OrderDetail> getOrderDetailsByOrderID(int orderID) {
        List<OrderDetail> list = new ArrayList<>();

        String sql = "SELECT od.OrderID, od.LaptopID, od.Quantity, od.UnitPrice,\n"
                + "       l.LaptopID, l.LaptopName, l.ImageURL\n"
                + "FROM OrderDetail od\n"
                + "JOIN Laptop l ON od.LaptopID = l.LaptopID\n"
                + "WHERE od.OrderID = ?";

        try {
            PreparedStatement ps = connect.prepareCall(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderID(rs.getInt("OrderID"));
                od.setQuantity(rs.getInt("Quantity"));
                od.setUnitPrice(rs.getBigDecimal("UnitPrice"));

                Laptop laptop = new Laptop();
                laptop.setLaptopID(rs.getInt("LaptopID"));
                laptop.setLaptopName(rs.getString("LaptopName"));
                laptop.setImageURL(rs.getString("ImageURL"));

                od.setLaptop(laptop);  

                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
