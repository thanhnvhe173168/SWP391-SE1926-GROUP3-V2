/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.*;

/**
 *
 * @author Window 11
 */
public class VoucherDAO extends ConnectDB {

    public List<Voucher> GetListVoucher() {
        List<Voucher> listvoucher = new ArrayList<>();
        String sql = "select * from Voucher";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherID(rs.getInt("voucherID"));
                v.setVouchercode(rs.getString("vouchercode"));
                v.setVouchertype(rs.getString("VoucherType"));
                v.setDiscount(rs.getBigDecimal("discount"));
                v.setQuantity(rs.getInt("quantity"));
                listvoucher.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listvoucher;
    }

    public BigDecimal GetdisountbyID(int id) {
        BigDecimal discount = new BigDecimal(0);
        String sql = "select discount from voucher where voucherid=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            discount = rs.getBigDecimal("discount");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return discount;

    }

    public int GetIDbyCode(String code) {
        int id = 0;
        String sql = "select * from voucher where vouchercode=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setString(1, code);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt("voucherID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;

    }

    public Voucher GetVoucherByID(int id) {
        Voucher vou = new Voucher();
        String sql = "select * from voucher where voucherid=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                vou.setVoucherID(id);
                vou.setVouchercode(rs.getNString("vouchercode"));
                vou.setVouchertype(rs.getNString("VoucherType"));
                vou.setDiscount(rs.getBigDecimal("discount"));
                vou.setQuantity(rs.getInt("quantity"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vou;

    }

    public void DeleteVoucherByID(int id) {
        String sql = "delete from Voucher where VoucherID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void EditVoucher(Voucher v) {
        String sql = "UPDATE Voucher\n"
                + "SET VoucherCode = ?,\n"
                + "    VoucherType = ?,\n"
                + "    Discount = ?,\n"
                + "    Quantity = ?\n"
                + "WHERE VoucherID = ?;";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setNString(1, v.getVouchercode());
            st.setNString(2, v.getVouchertype());
            st.setBigDecimal(3, v.getDiscount());
            st.setInt(4, v.getQuantity());
            st.setInt(5, v.getVoucherID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void AddVoucher(Voucher v) {
        String sql = "INSERT INTO Voucher (VoucherCode, VoucherType, Discount, Quantity)\n"
                + "VALUES (?, ?, ?, ?);";
        try{
            PreparedStatement st= connect.prepareStatement(sql);
            st.setNString(1, v.getVouchercode());
            st.setNString(2, v.getVouchertype());
            st.setBigDecimal(3, v.getDiscount());
            st.setInt(4, v.getQuantity());
            st.executeUpdate();
        }
        catch(SQLException e){
            e.printStackTrace();
        }
    }
}
