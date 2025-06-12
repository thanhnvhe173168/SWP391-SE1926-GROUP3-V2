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

    public int GetLastOrderID(int userid) {
        String sql = "SELECT MAX(OrderID) AS lastOrderID FROM Orders where userID=?;";
        int id = 0;
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userid);
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
            while (rs.next()) {
                Order od = new Order();

                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                orderlist.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderlist;
    }

    public List<Order> getListOrderByPaymentStatusName(String statusname) {
        String sql = "select * from orders o \n"
                + "join Statuses s on o.PaymentStatusID=s.StatusID\n"
                + "where s.StatusName=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, statusname);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getListOrderByStatusName(String statusname) {
        String sql = "select * from orders o \n"
                + "join Statuses s on o.StatusID=s.StatusID\n"
                + "where s.StatusName=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, statusname);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getListOrderNeedEvaluate() {
        String sql = "select * from Orders o \n"
                + "join OrderDetail od on o.OrderID=od.OrderID\n"
                + "where od.ReviewID is null \n"
                + "and o.StatusID = 7";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getListUserOrder(int userid) {
        String sql = "select * from Orders where UserID=?";
        List<Order> orderlist = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();

                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                orderlist.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderlist;
    }
    
    public List<Order> getListUserOrderByPaymentStatusName(String statusname, int userid) {
        String sql = "select * from orders o \n"
                + "join Statuses s on o.PaymentStatusID=s.StatusID\n"
                + "where s.StatusName=? and userid=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, statusname);
            st.setInt(2, userid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getListUserOrderByStatusName(String statusname, int userid) {
        String sql = "select * from orders o \n"
                + "join Statuses s on o.StatusID=s.StatusID\n"
                + "where s.StatusName=? and userid=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, statusname);
            st.setInt(2, userid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getListUserOrderNeedEvaluate(int userid) {
        String sql = "select * from Orders o \n"
                + "join OrderDetail od on o.OrderID=od.OrderID\n"
                + "where od.ReviewID is null \n"
                + "and o.StatusID = 7 and userid=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order od = new Order();
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");

                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");

                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));

                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");

                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("shipfeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("totalAmount"));
                od.setUserID(rs.getInt("userID"));

                int voucherID = rs.getInt("voucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }

                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));

                if (rs.getDate("paymentDate") != null) {
                    od.setPaymentdate(rs.getDate("paymentDate").toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
