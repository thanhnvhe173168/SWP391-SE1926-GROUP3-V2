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
public class OrderDAO extends ConnectDB {

    FeeShipDAO fsdao = new FeeShipDAO();
    VoucherDAO voudao = new VoucherDAO();
    StatusDAO sdao = new StatusDAO();
    PaymentMethodDAO pmdao = new PaymentMethodDAO();

    public void uppdateorder(Order od) {
        String sql = "INSERT INTO Orders (\n"
                + "    UserID, OrderDate, ShipFeeID, TotalAmount, Address,\n"
                + "    Note, PhoneNumber, StatusID, VoucherID,\n"
                + "    PaymentMethodID, PaymentDate, PaymentStatusID,\n"
                + "    ReturnDate, ReasonReturn\n"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        try {
            PreparedStatement st = connect.prepareStatement(sql);

            st.setInt(1, od.getUserID());
            st.setDate(2, java.sql.Date.valueOf(od.getOrderDate()));
            st.setInt(3, od.getShipfee().getFeeShipID());
            st.setBigDecimal(4, od.getTotalAmount());
            st.setNString(5, od.getAddress());

            if (od.getNote() != null) {
                st.setNString(6, od.getNote());
            } else {
                st.setNull(6, java.sql.Types.NVARCHAR);
            }

            st.setString(7, od.getPhoneNumber());
            st.setInt(8, od.getOrderstatus().getStatusID());

            if (od.getVoucher() != null) {
                st.setInt(9, od.getVoucher().getVoucherID());
            } else {
                st.setNull(9, java.sql.Types.INTEGER);
            }

            st.setInt(10, od.getPaymentmethod().getPaymentMethodID());

            // PaymentDate (nullable, override default if present)
            if (od.getPaymentdate() != null) {
                st.setDate(11, java.sql.Date.valueOf(od.getPaymentdate()));
            } else {
                st.setNull(11, java.sql.Types.DATE);
            }

            st.setInt(12, od.getPaymentstatus().getStatusID());

            // ReturnDate (nullable)
            if (od.getReturnDate() != null) {
                st.setDate(13, java.sql.Date.valueOf(od.getReturnDate()));
            } else {
                st.setNull(13, java.sql.Types.DATE);
            }

            // ReasonReturn (nullable)
            if (od.getReasonReturn() != null) {
                st.setNString(14, od.getReasonReturn());
            } else {
                st.setNull(14, java.sql.Types.NVARCHAR);
            }

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

    public Order GetOrderByID(int id) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        Order od = new Order();

        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                String address = rs.getNString("Address");
                od.setAddress(address != null ? address : "");
                String note = rs.getNString("Note");
                od.setNote(note != null ? note : "");
                od.setOrderDate(rs.getDate("OrderDate").toLocalDate());
                od.setOrderID(rs.getInt("OrderID"));
                od.setPaymentmethod(pmdao.GetPaymentMethodByID(rs.getInt("PaymentMethodID")));
                String phone = rs.getString("PhoneNumber");
                od.setPhoneNumber(phone != null ? phone : "");
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return od;
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);

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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getListReturnOrderByStatusName(String statusname1, String statusname2) {
        String sql = "select * from orders o \n"
                + "join Statuses s on o.StatusID=s.StatusID\n"
                + "where s.StatusName=? or s.StatusName=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, statusname1);
            st.setNString(2, statusname2);
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
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
                + "and (o.StatusID = 7 or o.StatusID = 14)";
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getListUserReturnOrderByStatusName(String statusname1, String statusname2, int userid) {
        String sql = "select * from orders o \n"
                + "join Statuses s on o.StatusID=s.StatusID\n"
                + "where (s.StatusName=? or s.StatusName=?) and userid=?";
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, statusname1);
            st.setNString(2, statusname2);
            st.setInt(3, userid);
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
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
                + "and (o.StatusID = 7 or o.StatusID = 14)and userid=?";
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
                od.setShipfee(fsdao.getFeeShipByID(rs.getInt("ShipFeeID")));
                od.setOrderstatus(sdao.GetStatus(rs.getInt("StatusID")));
                od.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                od.setUserID(rs.getInt("UserID"));
                int voucherID = rs.getInt("VoucherID");
                if (!rs.wasNull()) {
                    od.setVoucher(voudao.GetVoucherByID(voucherID));
                } else {
                    od.setVoucher(null);
                }
                od.setPaymentstatus(sdao.GetStatus(rs.getInt("PaymentStatusID")));
                Date paymentDate = rs.getDate("PaymentDate");
                if (paymentDate != null) {
                    od.setPaymentdate(paymentDate.toLocalDate());
                } else {
                    od.setPaymentdate(null);
                }
                Date returnDate = rs.getDate("ReturnDate");
                if (returnDate != null) {
                    od.setReturnDate(returnDate.toLocalDate());
                } else {
                    od.setReturnDate(null);
                }
                String reasonReturn = rs.getNString("ReasonReturn");
                od.setReasonReturn(reasonReturn != null ? reasonReturn : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void upDateOrderStatus(int statusid, int orderid) {
        String sql = "update Orders\n"
                + "set StatusID=?\n"
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

    public void updateReasonReturn(int orderid, String reason, LocalDate returndate) {
        String sql = "UPDATE Orders\n"
                + "set ReasonReturn=?,\n"
                + "ReturnDate=?\n"
                + "where OrderID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, reason);
            st.setDate(2, java.sql.Date.valueOf(returndate));
            st.setInt(3, orderid);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
