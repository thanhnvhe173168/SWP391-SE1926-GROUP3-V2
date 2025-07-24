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
                + "    PaymentMethodID, PaymentStatusID,\n"
                + "    ReasonCancel\n"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

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

            st.setInt(11, od.getPaymentstatus().getStatusID());

            if (od.getReasonCancel() != null) {
                st.setNString(12, od.getReasonCancel());
            } else {
                st.setNull(12, java.sql.Types.NVARCHAR);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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
                + "and (o.StatusID = 12 or o.StatusID = 22)";
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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
                + "and (o.StatusID = 12 or o.StatusID = 22)and userid=?";
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
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

    public void updateOrderPaymentStatus(Order order) {
        String sql = "update Orders\n"
                + "set PaymentStatusID=?\n"
                + "where OrderID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, order.getPaymentstatus().getStatusID());
            st.setInt(2, order.getOrderID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getShipperOrderList() {
        String sql = "select * from Orders \n"
                + "where StatusID=15 or StatusID=10 or StatusID=11 or StatusID=12 or StatusID=13 or StatusID=14 or StatusID=23 or StatusID=24 or StatusID=25 or StatusID=18 or StatusID=19";
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getOrdersByPage(int offset, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders\n"
                + "order by OrderID desc\n"
                + "offset ? rows fetch next ? rows only";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, offset);
            st.setInt(2, pageSize);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getUserOrdersByPage(int offset, int pageSize, int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders\n"
                + "where UserID=?\n"
                + "order by OrderID desc\n"
                + "offset ? rows fetch next ? rows only";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, offset);
            st.setInt(3, pageSize);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getShipOrdersByPage(int offset, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders\n"
                + "where StatusID=15 or StatusID=10 or StatusID=11 or StatusID=12 or StatusID=13 or StatusID=14 or StatusID=23 or StatusID=24 or StatusID=25 or StatusID=18 or StatusID=19\n"
                + "order by OrderID desc\n"
                + "offset ? rows fetch next ? rows only";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, offset);
            st.setInt(2, pageSize);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countOrders() {
        int count = 0;
        String sql = "select COUNT(*) as count from Orders";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            count = rs.getInt("count");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countOrdersByStatusID(int statusid) {
        int count = 0;
        String sql = "select COUNT(*) from Orders where StatusID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countReturnOrdersByStatusID(int statusid1, int statusid2) {
        int count = 0;
        String sql = "select COUNT(*) from Orders where StatusID=? or StatusID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid1);
            st.setInt(2, statusid2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countShipOrders() {
        int count = 0;
        String sql = "select COUNT(*) from Orders where StatusID=15 or StatusID=10 or StatusID=11 or StatusID=12 or StatusID=13 or StatusID=14 or StatusID=23 or StatusID=24 or StatusID=25";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public void updateReasonCancel(String reason, int id) {
        String sql = "update Orders\n"
                + "set ReasonCancel=?\n"
                + "where OrderID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, reason);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getListOrderHaveEvaluate() {
        String sql = "select * from Orders o \n"
                + "join OrderDetail od on o.OrderID=od.OrderID\n"
                + "where od.ReviewID is not null \n"
                + "and (o.StatusID = 12 or o.StatusID = 22)";
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getOrdersByPageandStatus(int offset, int pageSize, int statusid) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders\n"
                + "where StatusID= ?\n"
                + "order by OrderID desc\n"
                + "offset ? rows fetch next ? rows only";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid);
            st.setInt(2, offset);
            st.setInt(3, pageSize);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getReturnOrdersByPageandStatus(int offset, int pageSize, int statusid1, int statusid2) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders\n"
                + "where StatusID= ? or statusid = ?\n"
                + "order by OrderID desc\n"
                + "offset ? rows fetch next ? rows only";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid1);
            st.setInt(2, statusid2);
            st.setInt(3, offset);
            st.setInt(4, pageSize);
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

                String reasonCancel = rs.getNString("ReasonCancel");
                od.setReasonCancel(reasonCancel != null ? reasonCancel : null);
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getTotalRevenue() {
        double total = 0;
        String sql = "select SUM(TotalAmount) as TotalAmount from Orders where StatusID=22 and PaymentStatusID=27 group by OrderID";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("TotalAmount");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public ArrayList<Double> getRevenueByMonth(int year) {
        ArrayList<MonthlyRevenue> listMonthlyRevenue = new ArrayList<>();      
        ArrayList<Double> listRevenue = new ArrayList<>();
        String sql = "SELECT MONTH(OrderDate) AS Month, SUM(TotalAmount) AS TotalRevenue FROM Orders "
                + "WHERE YEAR(orderdate) = ? AND StatusID = 22 and PaymentStatusID = 27"
                + "GROUP BY MONTH(OrderDate) ORDER BY Month";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                listMonthlyRevenue.add(new MonthlyRevenue(
                        rs.getInt("Month"),
                        rs.getDouble("TotalRevenue"))
                );
            };
            for (int i = 1; i <= 12; i++) {
                int flag = 0;
                for (MonthlyRevenue m : listMonthlyRevenue) {
                    if (m.getMonth() == i) {
                        listRevenue.add(m.getRevenue());
                        flag++;
                    }
                }
                if (flag == 0) {
                    listRevenue.add(0.0);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listRevenue;
    }

}
