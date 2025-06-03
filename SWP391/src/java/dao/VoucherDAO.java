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
public class VoucherDAO extends ConnectDB{
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
                v.setDiscount(rs.getBigDecimal("discount"));
                v.setQuantity(rs.getInt("quantity"));
                listvoucher.add(v);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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
    
}
