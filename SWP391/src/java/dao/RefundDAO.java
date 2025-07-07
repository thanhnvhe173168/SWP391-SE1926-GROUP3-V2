/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.Refund;
import config.ConnectDB;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Window 11
 */
public class RefundDAO extends ConnectDB {

    public void addRefund(Refund refund) {
        String sql = "INSERT INTO Refund (payment_id, amount, refund_type, refund_transaction_no, create_date, statusid, create_by) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, refund.getPaymentId());
            ps.setBigDecimal(2, refund.getAmount());
            ps.setString(3, refund.getRefundType());
            ps.setString(4, refund.getRefundTransactionNo());
            if (refund.getCreateDate() != null) {
                ps.setTimestamp(5, Timestamp.valueOf(refund.getCreateDate()));
            } else {
                ps.setTimestamp(5, null);
            }
            ps.setInt(6, refund.getStatusId());
            ps.setString(7, refund.getCreateBy());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
